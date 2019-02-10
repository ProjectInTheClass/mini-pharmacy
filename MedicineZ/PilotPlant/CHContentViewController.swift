//
//  CHImageScrollViewController.swift
//  PilotPlantSwift
//
//  Created by lingostar on 2014. 11. 1..
//  Copyright (c) 2014년 lingostar. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import MediaPlayer
import AVFoundation
import AVKit


public class ImageScrollScene : UIViewController, UIScrollViewDelegate {
    @IBInspectable open var imageName: String = ""
    
    var imageScrollView : UIScrollView?
    var imageView:UIImageView?
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let targetImage = UIImage(named: imageName)
        let imageSize : CGSize = targetImage!.size
        
        for view in self.view.subviews {
            if view is UIScrollView {
                imageScrollView = view as! UIScrollView
            }
        }
        
        if let scrollView = imageScrollView?.superview  {
            
        } else {
            imageScrollView = UIScrollView(frame: CGRect.zero)
            imageScrollView?.frame = self.view.frame
            self.view.addSubview(imageScrollView!)
        }
        imageScrollView?.delegate = self
        
        imageView = UIImageView(image: targetImage)
        imageScrollView?.addSubview(imageView!)
        imageScrollView?.contentSize = imageSize
        
    }
    
    @IBAction func zoomToScale(sender: AnyObject) {
        self.scaleTo(sender)
    }
    
    open func scaleTo(_ sender: AnyObject) {
        guard let pinchGesture = sender as? UIPinchGestureRecognizer else {
            return
        }
        let currentScale = imageScrollView?.zoomScale
        
        let state = pinchGesture.state
        if (state == .began || state == .changed)
        {
            let scale = currentScale! + (pinchGesture.scale - 1.0)
            imageScrollView?.zoomScale = scale
            pinchGesture.scale = 1.0
        }
    }
    
    open func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("Did Scroll")
    }
    
    open func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("Did End Dragging")
    }
    
    open func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print("Will End Dragging, velocity = \(velocity.x) ,  \(velocity.y)")
    }
}



open class MapScene: UIViewController {
    @IBInspectable open var mapCenter = CGPoint(x: 36.976775, y: 128.362891)
    @IBInspectable open var mapSpan = CGSize(width: 0.005, height: 0.005)
    
    var chMapView = MKMapView()
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        for view in self.view.subviews {
            if view is MKMapView {
                chMapView = view as! MKMapView
            }
        }
        
        if chMapView.superview == nil {
            chMapView.frame = self.view.frame
            self.view.addSubview(chMapView)
        }
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let center = CLLocationCoordinate2DMake(Double(mapCenter.x), Double(mapCenter.y))
        let span = MKCoordinateSpan(latitudeDelta: Double(mapSpan.width), longitudeDelta: Double(mapSpan.height))
        let region = MKCoordinateRegion(center: center, span: span)
        chMapView.setRegion(region, animated: true)
    }
}


open class WebScene: UIViewController {
    @IBInspectable open var pageURL : String = "www.codershigh.com"
    @IBInspectable open var isLocal : Bool  = false
    var chWebView = UIWebView()

    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        for view in self.view.subviews {
            if view is UIWebView {
                chWebView = view as! UIWebView
            }
        }
        
        if chWebView.superview == nil {
            chWebView.frame = self.view.frame
            self.view.addSubview(chWebView)
        }
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        var tidyURL : URL!
        if isLocal {
            let nameArray = pageURL.components(separatedBy: ".")
            tidyURL = Bundle.main.url(forResource: nameArray[0], withExtension: nameArray[1])
        } else {
            if pageURL.hasPrefix("http://") {
                tidyURL = URL(string: pageURL as String)
            } else {
                tidyURL = URL(string: "http://" + (pageURL as String))
            }
        }
        
        let urlRequest = URLRequest(url: tidyURL)
        chWebView.loadRequest(urlRequest)
    }
}


open class MovieScene: AVPlayerViewController {
    @IBInspectable open var movieName = ""
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let movieURL = Bundle.main.url(forResource: movieName, withExtension: "mov")
        
        self.player = AVPlayer(url: movieURL!)
        self.player?.play()
    }
}


open class AudioScene:UIViewController, AVAudioPlayerDelegate {
    
    @IBInspectable open var audioFileName:String! = nil
    var audioPlayer:AVAudioPlayer? = nil
    
    open override func viewDidAppear(_ animated: Bool) {
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: .default)

        } catch {
            
        }
        
        let audioURL:URL = Bundle.main.url(forResource: audioFileName, withExtension: "aiff")!
        do {
            audioPlayer = try AVAudioPlayer(contentsOf:audioURL)
            audioPlayer?.delegate = self
            audioPlayer?.volume = 1.0
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            
        }
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        audioPlayer = nil
    }
}


@IBDesignable
public class TableViewSectionHeaderScene : UITableViewController
{
    @IBOutlet var headerViews:[UIView] = []
    
    public override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerViews[section]
    }
    
}
