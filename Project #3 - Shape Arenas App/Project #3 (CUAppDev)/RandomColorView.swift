//
//  RandomColorView.swift
//  Project #3 (CUAppDev)
//
//  Created by Annie Cheng on 1/7/15.
//  Copyright (c) 2015 Annie Cheng. All rights reserved.
//

import UIKit

class RandomColorView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        let randomRed: CGFloat = CGFloat(drand48())
        let randomGreen: CGFloat = CGFloat(drand48())
        let randomBlue: CGFloat = CGFloat(drand48())
        self.backgroundColor = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
