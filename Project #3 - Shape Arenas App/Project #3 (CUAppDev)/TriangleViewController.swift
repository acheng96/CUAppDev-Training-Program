//
//  TriangleViewController.swift
//  Project #3 (CUAppDev)
//
//  Created by Annie Cheng on 1/6/15.
//  Copyright (c) 2015 Annie Cheng. All rights reserved.
//

import UIKit

class TriangleViewController: UIViewController {
    
    // Variable declarations
    var currentWidthValue: Int!
    var currentHeightValue: Int!
    
    // Outlets
    @IBOutlet weak var widthLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var widthSlider: UISlider!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var widthNumLabel: UILabel!
    @IBOutlet weak var heightNumLabel: UILabel!
    @IBOutlet weak var addDeleteController: UISegmentedControl!
    
    // When view loads for the first time
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        widthSlider.minimumValue = 0
        widthSlider.maximumValue = 100
        widthSlider.value = widthSlider.maximumValue/2
        heightSlider.minimumValue = 0
        heightSlider.maximumValue = 100
        heightSlider.value = heightSlider.maximumValue/2
    }
    
    @IBAction func widthValueChanged(sender: UISlider) {
        currentWidthValue = Int(sender.value)
        widthNumLabel.text = "\(currentWidthValue)"
    }
    
    @IBAction func heightValueChanged(sender: UISlider) {
        currentHeightValue = Int(sender.value)
        heightNumLabel.text = "\(currentHeightValue)"
    }
    
    // Add green triangle each time the user touches the screen
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        currentWidthValue = Int(widthSlider.value)
        currentHeightValue = Int(heightSlider.value)
        let location = touches.first?.locationInView(view)
        if addDeleteController.selectedSegmentIndex == 0 {
            for touch in touches {
                let triangleCenter = touch.locationInView(view)
                let triangleView = TriangleView(frame: CGRectMake(triangleCenter.x, triangleCenter.y,
                    CGFloat(currentWidthValue), CGFloat(currentHeightValue)))
                triangleView.center = location!
                view.addSubview(triangleView)
                
            }
        } else if addDeleteController.selectedSegmentIndex == 1 {
            var count = 0
            for view in Array(self.view.subviews.reverse()) {
                if let triangleTapped = view.layer.presentationLayer()!.frame?.contains(location!) {
                    if triangleTapped && count < 1 {
                        view.removeFromSuperview()
                        count += 1
                    }
                }
            }
        }

    }
}
