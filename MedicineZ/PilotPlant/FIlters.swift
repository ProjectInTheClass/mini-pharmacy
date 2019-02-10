//
//  FIlters.swift
//  LINEPrototype
//
//  Created by Lingostar on 2016. 12. 7..
//  Copyright © 2016년 CodersHigh. All rights reserved.
//

import Foundation
import UIKit
import CoreMedia
import CoreGraphics
import CoreImage

typealias Filter = (CIImage) -> CIImage

extension CGRect {
    var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
}

func blendWithMask(background: CIImage, mask: CIImage) -> Filter {
    return { image in
        let parameters = [
            kCIInputBackgroundImageKey: background,
            kCIInputMaskImageKey: mask,
            kCIInputImageKey: image
        ]
        let filter = CIFilter(name: "CIBlendWithMask",
                              parameters: parameters)
        let cropRect = image.extent

        #if swift(>=4.0)
        return filter!.outputImage!.cropped(to:cropRect)
        #else
        return filter!.outputImage!.cropping(to:cropRect)
        #endif
        

    }
}

func maskImage(rect:CGRect, xPosition:CGFloat) -> CIImage {
    
    let maskRect = CGRect(x: xPosition, y: 0, width:rect.size.width - xPosition , height: rect.size.height)
    
    let colorSpace = CGColorSpaceCreateDeviceGray()
    let context = CGContext(data: nil, width: Int(rect.size.width), height: Int(rect.size.height), bitsPerComponent: 8, bytesPerRow: Int(rect.size.width), space: colorSpace, bitmapInfo:0)
    context?.setFillColor(UIColor.white.cgColor)
    context?.fill(rect)
    context?.addPath(CGPath(rect: maskRect, transform: nil))
    context?.setFillColor(UIColor.black.cgColor)
    context?.fillPath()
    
    let viewImage = context?.makeImage()
    return CIImage(cgImage: viewImage!)
}


func pixellate(scale: Float) -> Filter {
    return { image in
        let parameters = [
            kCIInputImageKey:image,
            kCIInputScaleKey:scale
            ] as [String : Any]
        return CIFilter(name: "CIPixellate", parameters: parameters)!.outputImage!
    }
}



func comicEffect() -> Filter {
    return { image in
        return CIFilter(name: "CIComicEffect")!.outputImage!
    }
}

func hueAdjust(angleInRadians: Float) -> Filter {
    return { image in
        let parameters = [
            kCIInputAngleKey: angleInRadians,
            kCIInputImageKey: image
        ] as [String : Any]
        let filter = CIFilter(name: "CIHueAdjust",
                              parameters: parameters)
        return filter!.outputImage!
    }
}

