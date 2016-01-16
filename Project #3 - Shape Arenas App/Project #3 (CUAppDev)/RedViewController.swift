//
//  RedViewController.swift
//  Project #3 (CUAppDev)
//
//  Created by Annie Cheng on 1/6/15.
//  Copyright (c) 2015 Annie Cheng. All rights reserved.
//

import UIKit

class RedViewController: UIViewController {
    
    // Variable declarations
    var currentWidthValue: Int!
    var currentHeightValue: Int!

    // Outlets
    @IBOutlet weak var widthSlider: UISlider!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var widthLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var widthNumLabel: UILabel!
    @IBOutlet weak var heightNumLabel: UILabel!
    @IBOutlet weak var addDeleteController: UISegmentedControl!
    
    // When view loads for the first time
    override func viewDidLoad() {
        super.viewDidLoad()
        widthSlider.minimumValue = 0
        widthSlider.maximumValue = 100
        widthSlider.value = heightSlider.maximumValue/2
        heightSlider.minimumValue = 0
        heightSlider.maximumValue = 100
        heightSlider.value = heightSlider.maximumValue/2
    }
    
    // Width slider
    @IBAction func widthValueChanged(sender: UISlider) {
        currentWidthValue = Int(sender.value)
        widthNumLabel.text = "\(currentWidthValue)"
    }
    
    // Height slider
    @IBAction func heightValueChanged(sender: UISlider) {
        currentHeightValue = Int(sender.value)
        heightNumLabel.text = "\(currentHeightValue)"
    }
    
    // Add red rectangles when user touches the screen
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        currentWidthValue = Int(widthSlider.value)
        currentHeightValue = Int(heightSlider.value)
        let location = touches.first?.locationInView(view)
        if addDeleteController.selectedSegmentIndex == 0 {
            let redView = UIView(frame: CGRect(x: 0, y: 0, width: currentWidthValue, height: currentHeightValue))
            redView.center = location!
            redView.backgroundColor = UIColor.redColor()
            view.addSubview(redView)
        } else if addDeleteController.selectedSegmentIndex == 1 {
            var count = 0
            for view in Array(self.view.subviews.reverse()) {
                if let squareTapped = view.layer.presentationLayer()!.frame?.contains(location!) {
                    if squareTapped && count < 1 {
                        view.removeFromSuperview()
                        count += 1
                    }
                }
            }
        }
    }
}
