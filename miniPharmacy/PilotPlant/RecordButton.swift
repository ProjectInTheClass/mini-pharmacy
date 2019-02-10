//
//  RecordButton.swift
//  RecordButton
//
//  Created by Lingostar on 2016. 12. 4..
//  Copyright © 2016년 CodersHigh. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

@IBDesignable
class RecordButtoon:UIView {
    
    var backgroundRingLayer: CAShapeLayer?
    var progressLayer: CAShapeLayer?
    
    var recordLabel: UILabel?
    var recordStopButton: UIButton?
    var longPressRecognizer:UILongPressGestureRecognizer?
    var progressTimer:Timer?
    
    @IBInspectable var isRecording: Bool = false {
        didSet {
            if isRecording == true{
                progress = 0.0
                self.setNeedsLayout()
                longPressRecognizer?.isEnabled = false
            } else {
                longPressRecognizer?.isEnabled = true
            }
        }
    }
    
    @IBInspectable var progress: Double = 0.0 {
        didSet { updateLayerProperties() }
    }
    @IBInspectable var lineWidth: Double = 4.0 {
        didSet { updateLayerProperties() }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeButton()
    }
    
    func initializeButton() {
        print ("Initialized")
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(RecordButtoon.tapAction))
        self.addGestureRecognizer(tapRecognizer)
        
        
        longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(RecordButtoon.longPressAction))
        self.addGestureRecognizer(longPressRecognizer!)
        self.setNeedsLayout()
    }

    
    @objc func tapAction() {
        print("Tap")
        
        let blink = CABasicAnimation(keyPath: "fillColor")
        blink.fromValue = UIColor.darkGray.cgColor
        blink.toValue = UIColor.white.cgColor
        blink.duration = 0.5
        
        self.backgroundRingLayer?.add(blink, forKey: "fillColor")
    }
    

    @objc func longPressAction() {

        print("LongPress")
        self.layoutLabel(show: true)
        zoomIn()
        
        self.isRecording = true
        if progressTimer == nil {
            if #available(iOS 10.0, *) {
                progressTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {_ in
                    self.progress += 0.05
                    self.recordLabel?.text = String(format:"00:%02d", Int(self.progress / 0.05))
                    self.updateLayerProperties()
                    self.setNeedsLayout()
                })
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()

        if backgroundRingLayer == nil {
            
            backgroundRingLayer = CAShapeLayer()
            layer.addSublayer(backgroundRingLayer!)
            
            let rect = (bounds).insetBy(dx: CGFloat(lineWidth / 2.0), dy: CGFloat(lineWidth / 2.0))
            let path = UIBezierPath(ovalIn:rect)
            
            backgroundRingLayer?.path = path.cgPath
            backgroundRingLayer?.fillColor = UIColor.white.cgColor
            backgroundRingLayer?.lineWidth = 8.0
            backgroundRingLayer?.strokeColor = UIColor.gray.cgColor
            
        }
        backgroundRingLayer?.frame = layer.bounds
        
        if isRecording == true {
            if (progressLayer == nil) {
                progressLayer = CAShapeLayer()
                layer.addSublayer(progressLayer!)
                
                let innerRect = (bounds).insetBy(dx: CGFloat(lineWidth / 2.0), dy: CGFloat(lineWidth / 2.0))
                let innerPath = UIBezierPath(ovalIn:innerRect)
                
                progressLayer?.path = innerPath.cgPath
                progressLayer?.fillColor = nil
                progressLayer?.lineWidth = CGFloat(2.0)
                progressLayer?.strokeColor = UIColor.red.cgColor
                
                var rotationWithPerspective = CATransform3DIdentity;
                let radians = 3 * (Double.pi / 2)
                rotationWithPerspective = CATransform3DRotate(rotationWithPerspective, CGFloat(radians), 0, 0, 1);
                
                progressLayer?.transform = rotationWithPerspective
            }
            progressLayer?.frame = layer.bounds
        }
        
        updateLayerProperties()
    }
    
    func layoutLabel(show:Bool) {
        if show == true {
            let origin = self.bounds.origin
            let size = self.bounds.size
            recordLabel = UILabel(frame: CGRect(x: origin.x, y: -20, width: size.width, height: 20))
            recordLabel!.font = UIFont.systemFont(ofSize: 10)
            recordLabel!.textColor = UIColor.white
            recordLabel!.textAlignment = .center
            self.addSubview(recordLabel!)
        } else {
            recordLabel?.removeFromSuperview()
        }
    }
    
    
    func layoutStopButton(show:Bool) {
        if show == true {
            let center = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
            recordStopButton = UIButton(frame: CGRect(x: center.x - 10, y: center.y - 10, width: 20, height: 20))
            recordStopButton?.backgroundColor = UIColor.red
            recordStopButton?.addTarget(self, action: #selector(stopRecord), for: .touchUpInside)
            self.addSubview(recordStopButton!)
        } else {
            recordStopButton?.removeFromSuperview()
        }
        
    }
    
    @objc func stopRecord() {
        self.isRecording = false
        self.layoutLabel(show: false)
        self.layoutStopButton(show: false)
        self.progress = 0.0
        progressTimer?.invalidate()
        progressTimer = nil
        self.setNeedsLayout()
    }
    
    func updateLayerProperties(){
        guard let progressL = progressLayer else {
            return
        }
        progressL.strokeEnd = CGFloat(progress)
        progressL.lineWidth = 2.0
        
        if isRecording == true {
            backgroundRingLayer?.fillColor = UIColor.clear.cgColor
            backgroundRingLayer?.lineWidth = CGFloat(2.0)
            backgroundRingLayer?.strokeColor = UIColor.white.cgColor
        } else {
            backgroundRingLayer?.fillColor = UIColor.white.cgColor
            backgroundRingLayer?.lineWidth = CGFloat(8.0)
            backgroundRingLayer?.strokeColor = UIColor.gray.cgColor
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        zoomOut()
        self.layoutStopButton(show: true)
        self.setNeedsLayout()
    }
    
    func zoomIn(duration: TimeInterval = 0.2) {
        self.transform = .identity
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
        }) { (animationCompleted: Bool) -> Void in
        }
    }
    
    func zoomOut(duration: TimeInterval = 0.2) {
        self.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.transform = .identity
        }) { (animationCompleted: Bool) -> Void in
        }
    }
    
    func zoomInWithEasing(duration: TimeInterval = 0.2, easingOffset: CGFloat = 0.2) {
        let easeScale = 1.0 + easingOffset
        let easingDuration = TimeInterval(easingOffset) * duration / TimeInterval(easeScale)
        let scalingDuration = duration - easingDuration
        UIView.animate(withDuration: scalingDuration, delay: 0.0, options: .curveEaseIn, animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: easeScale, y: easeScale)        }, completion: { (completed: Bool) -> Void in
            UIView.animate(withDuration: easingDuration, delay: 0.0, options: .curveEaseOut, animations: { () -> Void in
                self.transform = .identity
            }, completion: { (completed: Bool) -> Void in
            })
        })
    }
    

    func zoomOutWithEasing(duration: TimeInterval = 0.2, easingOffset: CGFloat = 0.2) {
        let easeScale = 1.0 + easingOffset
        let easingDuration = TimeInterval(easingOffset) * duration / TimeInterval(easeScale)
        let scalingDuration = duration - easingDuration
        UIView.animate(withDuration: easingDuration, delay: 0.0, options: .curveEaseOut, animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: easeScale, y: easeScale)
        }, completion: { (completed: Bool) -> Void in
            UIView.animate(withDuration: scalingDuration, delay: 0.0, options: .curveEaseOut, animations: { () -> Void in
                self.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
            }, completion: { (completed: Bool) -> Void in
            })
        })
    }
    
    
    func springAnimation() {
        
        self.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 6.0, options: .allowUserInteraction, animations: {
        self.transform = .identity
        }, completion: nil)
        
    }
    
    
    
    
    
}


//Gradient Stroke
//http://stackoverflow.com/questions/4733966/applying-a-gradient-to-cashapelayer
