//
//  CHViews.swift
//  PilotPlantCatalog
//
//  Created by Lingostar on 2017. 5. 2..
//  Copyright © 2017년 LingoStar. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
open class AnimationImageView:UIImageView {
    @IBInspectable open var imageBaseName:String = ""
    @IBInspectable open var duration:Double = 1.0
    @IBInspectable open var repeatCount:Int = 0
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        var images = [UIImage]()
        for i in 1 ..< 32000
        {
            let imageFileName = self.imageBaseName + "_\(i)"
            if let image = UIImage(named: imageFileName) {
                images.append(image)
            } else { break }
        }
        
        self.animationImages = images
        self.contentMode = .scaleAspectFit
        self.animationRepeatCount = self.repeatCount
        self.animationDuration = duration
        self.image = images.first
        self.startAnimating()
        
    }
}
