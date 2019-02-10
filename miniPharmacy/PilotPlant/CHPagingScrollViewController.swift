//
//  CHPagingScrollViewController.swift
//  PilotPlantSwift
//
//  Created by lingostar on 2014. 11. 1..
//  Copyright (c) 2014년 lingostar. All rights reserved.
//

import Foundation
import UIKit

let PAGECONTROL_HEIGHT:CGFloat = 37.0
let PAGE_Y = 0

open class PagingScene : UIViewController , UIScrollViewDelegate {
    @IBInspectable open var imageBaseName: String = ""
    @IBInspectable open var pageIndicator: Bool = false
    @IBInspectable open var pageSpace: Int = 0
    
    var pageSize:CGSize = CGSize(width: 0.0, height: 0.0)
    
    var pageScrollView : UIScrollView!
    var pageControl : UIPageControl? = nil
    
    override open func viewWillAppear(_ animated: Bool) {
        
        
        super.viewWillAppear(animated)
        
        for view in self.view.subviews {
            if view is UIScrollView {
                pageScrollView = view as! UIScrollView
                pageSize = pageScrollView.frame.size
            }
            if view is UIPageControl {
                pageControl = view as? UIPageControl
            }
        }
        
        if pageScrollView == nil {
            pageSize = self.view.frame.size
            if pageIndicator {
                pageSize.height -= (PAGECONTROL_HEIGHT - 5.0)
            }
            let scrollFrame = CGRect(x: 0, y: 0, width: pageSize.width, height: pageSize.height)
            pageScrollView = UIScrollView(frame: scrollFrame)
            self.view.addSubview(pageScrollView)
        }
        
        let imageFileName = imageBaseName + "_1"
        if let pageImage = UIImage(named: imageFileName){
            let imageSize = pageImage.size
            let scaleFactor = pageSize.height / imageSize.height
        }

        if let existingControl = pageControl {
            if (existingControl.superview == nil) {
                existingControl.frame = CGRect(x: 0, y: pageSize.height - PAGECONTROL_HEIGHT - 5.0, width: pageSize.width, height: PAGECONTROL_HEIGHT)
                self.view.addSubview(existingControl)
            }
        }
        
        
        pageScrollView.delegate = self
        pageScrollView.isScrollEnabled = true
        pageScrollView.isPagingEnabled = true
        pageScrollView.showsHorizontalScrollIndicator = false
        pageScrollView.showsVerticalScrollIndicator = false
        pageScrollView.bounces = false
        pageScrollView.alwaysBounceHorizontal = true
        
        
        var leftOrigin = 0
        let imageCount = 0

        for imageCount in 0..<99 {
            let imageFileName = imageBaseName + "_\(imageCount+1)"
            if let pageImage = UIImage(named: imageFileName){
                leftOrigin = imageCount*(Int(pageSize.width) + pageSpace) + pageSpace/2
                let rect = CGRect(x: CGFloat(leftOrigin), y: CGFloat(PAGE_Y), width: pageSize.width, height: pageSize.height)
                let pageContent = UIImageView(frame: rect)
                pageContent.contentMode = .scaleAspectFit
                pageContent.image = pageImage
                pageScrollView.addSubview(pageContent)
            } else {
                break
            }
        }

        pageScrollView.contentSize = CGSize(width: CGFloat(leftOrigin  + pageSpace) + pageSize.width, height: pageSize.height)
        pageControl?.numberOfPages = imageCount + 1
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        
    }
    
    open func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
    
    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = Double(pageScrollView.contentOffset.x ) / Double( Int(pageSize.width) + pageSpace )
        if pageControl != nil { pageControl!.currentPage = Int(pageNumber) }
    }
    
    func viewSize() -> CGSize {
        return self.view.bounds.size
    }
}

