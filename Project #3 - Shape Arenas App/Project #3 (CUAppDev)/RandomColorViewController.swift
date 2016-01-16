//
//  RandomColorViewController.swift
//  Project #3 (CUAppDev)
//
//  Created by Annie Cheng on 1/6/15.
//  Copyright (c) 2015 Annie Cheng. All rights reserved.
//

import UIKit

class RandomColorViewController: UIViewController {

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
        changeColor()
    }
    
    // Change width and height slider colors
    func changeColor() {
        widthSlider.thumbTintColor = getRandomColor()
        widthSlider.tintColor = getRandomColor()
        heightSlider.thumbTintColor = getRandomColor()
        heightSlider.tintColor = getRandomColor()
        addDeleteController.tintColor = getRandomColor()
    }
    
    // Return random color
    func getRandomColor() -> UIColor {
        let randomRed: CGFloat = CGFloat(drand48())
        let randomGreen: CGFloat = CGFloat(drand48())
        let randomBlue: CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    // Width slider
    @IBAction func widthValueChanged(sender: UISlider) {
        currentWidthValue = Int(sender.value)
        widthNumLabel.text = "\(currentWidthValue)"
    }
    
    // Value slider
    @IBAction func heightValueChanged(sender: UISlider) {
        currentHeightValue = Int(sender.value)
        heightNumLabel.text = "\(currentHeightValue)"
    }
    
    // Add random color rectangles when user touches the screen
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        changeColor()
        currentWidthValue = Int(widthSlider.value)
        currentHeightValue = Int(heightSlider.value)
        let location = touches.first?.locationInView(view)
        if addDeleteController.selectedSegmentIndex == 0 {
            for touch in touches {
                let rectCenter = touch.locationInView(view)
                let randomColorView = RandomColorView(frame: CGRectMake(rectCenter.x, rectCenter.y,
                    CGFloat(currentWidthValue), CGFloat(currentHeightValue)))
                randomColorView.center = location!
                view.addSubview(randomColorView)
            }
        } else if addDeleteController.selectedSegmentIndex == 1 {
            var count = 0
            for view in Array(self.view.subviews.reverse()) {
                if let rectTapped = view.layer.presentationLayer()!.frame?.contains(location!) {
                    if rectTapped && count < 1 {
                        view.removeFromSuperview()
                        count += 1
                    }
                }
            }
        }
    }
}
