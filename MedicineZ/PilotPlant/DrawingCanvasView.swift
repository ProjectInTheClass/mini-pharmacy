//
//  DrawingCanvasView.swift
//  LINEPrototype
//
//  Created by Lingostar on 2016. 12. 25..
//  Copyright © 2016년 CodersHigh. All rights reserved.
//

import UIKit

class Line {
    
    var start: CGPoint
    var end: CGPoint
    
    init(start _start: CGPoint, end _end: CGPoint ) {
        start = _start
        end = _end
    }
}

class DrawingCanvasView: UIView {

    var lines: [Line] = [] // Line is a custom class, shown below
    var lastPoint: CGPoint!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastPoint = touches.first?.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let newPoint = touches.first?.location(in: self)
        lines.append(Line(start: lastPoint, end: newPoint!))
        lastPoint = newPoint
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        context.beginPath()
        context.setLineCap(CGLineCap.round)

        for line in lines {
            context.move(to: line.start)
            context.addLine(to:line.end)
        }
        

        context.setStrokeColor(UIColor.red.cgColor)
        context.setLineWidth(5.0)
        context.strokePath()
    }

}
