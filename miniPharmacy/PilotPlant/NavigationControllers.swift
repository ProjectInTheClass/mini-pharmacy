//
//  NavigationControllers.swift
//  PilotPlant
//
//  Created by Lingostar on 2016. 12. 15..
//
//

import Foundation
import UIKit

@IBDesignable
public class TransparentNavigationController:UINavigationController
{
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.view.backgroundColor = UIColor.clear
    }
}


@IBDesignable
open class CHTabBar : UITabBar {
    @IBInspectable open var badgeOffsetX:Float = 0.0
    @IBInspectable open var badgeOffsetY:Float = 0.0
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        self.subviews.map({
            $0.subviews.map({ badgeView in
                if NSStringFromClass(badgeView.classForCoder) == "_UIBadgeView" {
                    badgeView.layer.transform = CATransform3DIdentity
                    badgeView.layer.transform = CATransform3DMakeTranslation(CGFloat(badgeOffsetX), CGFloat(badgeOffsetY), 1.0)
                }
            })
        })
    }
}


extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}

public class HalfSizePresentationController : UIPresentationController {
    
    public override var frameOfPresentedViewInContainerView: CGRect {
        return CGRect(x: 0, y: containerView!.bounds.height-500, width: containerView!.bounds.width, height: 500)
    }
}


open class Link: UIStoryboardSegue {
    override open func perform() {
        print("Linked")
    }
}
