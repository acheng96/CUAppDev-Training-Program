//
//  TriangleView.swift
//  Project #3 (CUAppDev)
//
//  Created by Annie Cheng on 1/6/15.
//  Copyright (c) 2015 Annie Cheng. All rights reserved.
//

import UIKit

class TriangleView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Draw green triangle
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, UIColor.greenColor().CGColor)
        CGContextMoveToPoint(context, 0, rect.height)
        CGContextAddLineToPoint(context, rect.width, rect.height)
        CGContextAddLineToPoint(context, rect.width / 2, rect.height - (rect.height * 0.866))
        CGContextAddLineToPoint(context, 0, rect.height)
        CGContextFillPath(context)
    }
        

}
