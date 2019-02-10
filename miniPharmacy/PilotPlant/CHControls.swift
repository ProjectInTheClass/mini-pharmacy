//
//  CHControls.swift
//  PilotPlant
//
//  Created by Lingostar on 2015. 11. 21..
//  Copyright © 2015년 LingoStar. All rights reserved.
//

import UIKit

@IBDesignable open class RoundRectButton: UIButton {
    
    @IBInspectable open var corner:Double = 8.0 {
        didSet {
            self.layoutIfNeeded()
        }
    }
    @IBInspectable open var border:Double = 2.0 {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    override open var isHighlighted : Bool {
        didSet {
            if isHighlighted {
                self.backgroundColor = self.tintColor
                self.layer.borderColor = self.titleColor(for: .highlighted)?.cgColor
            } else {
                self.backgroundColor = UIColor.clear
                self.layer.borderColor = self.tintColor?.cgColor
            }
        }
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        layoutRoundRectLayer()
    }
    
    private func layoutRoundRectLayer() {
        
        self.layer.cornerRadius =  CGFloat(corner)
        self.layer.borderColor = self.tintColor.cgColor
        self.layer.borderWidth = CGFloat(border)
    }
    
}

@IBDesignable
open class VerticalButton: UIButton {
    @IBInspectable open var topSpace:Double = 0.0 {
        didSet {
            self.layoutIfNeeded()
        }
    }
    @IBInspectable open var bottomSpace:Double = 0.0 {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if let imageFrame = self.imageView?.frame {
            let newImageFrame = CGRect(x: (self.bounds.size.width - imageFrame.size.width) / 2, y: (CGFloat(0.0 + topSpace)), width: imageFrame.size.width, height: imageFrame.size.height)
            self.imageView?.frame = newImageFrame
        }
        
        if let labelFrame = self.titleLabel?.frame {
            let newLabelFrame = CGRect(x: (self.bounds.size.width - labelFrame.size.width) / 2, y: self.bounds.size.height - labelFrame.size.height - CGFloat(bottomSpace), width: self.bounds.size.width, height: labelFrame.size.height)
            self.titleLabel?.frame = newLabelFrame
        }
    }
}

@IBDesignable
open class CirclarMaskImageView : UIImageView {
    @IBInspectable open var border:Double = 0.0 {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height / 2.0;
        self.layer.masksToBounds = true;
        self.layer.borderWidth = CGFloat(self.border);
        self.layer.borderColor = self.backgroundColor?.cgColor
    }
}



/*
@IBDesignable
open class CircleDotButton : CircleButton {
    var selectedLayer:CAShapeLayer = CAShapeLayer()

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let buttonSize = CGSize(width:self.bounds.size.width / 3.0, height: self.bounds.size.height / 3.0)
        let center = CGPoint(x:self.bounds.center.x - (buttonSize.width / 2.0) , y : self.bounds.center.y - (buttonSize.height / 2.0))
        let selectedDotRect = CGRect(origin: center, size: buttonSize)
        
        selectedLayer.path = UIBezierPath(ovalIn: selectedDotRect).cgPath
        selectedLayer.backgroundColor = UIColor.black.cgColor
        selectedLayer.opacity = 0.3
    }
    
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        if isSelected == true {
            self.layer.addSublayer(selectedLayer)
        } else {
            selectedLayer.removeFromSuperlayer()
        }
    }
}
*/

@IBDesignable
open class CircluarButton : UIButton {
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height / 2.0;
        self.layer.masksToBounds = true;
        self.layer.borderWidth = 0;
        
    }
}

open class ToggleButton : UIButton {
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addTarget(self, action: #selector(self.toggle), for: .touchUpInside)
    }
    
    @objc func toggle() {
        isSelected = !isSelected
    }
}
