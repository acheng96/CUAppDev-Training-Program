//
//  AddContactViewController.swift
//  Project #4 (CUAppDev)
//
//  Created by Annie Cheng on 1/7/15.
//  Copyright (c) 2015 Annie Cheng. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController, UITextFieldDelegate {

    // Outlets
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var friendEnemyController: UISegmentedControl!
    @IBOutlet weak var contactImage: UIImageView!
    
    // When view loads for the first time
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(red:0.8, green: 1.0, blue: 0.8, alpha: 1.0)
        friendEnemyController.tintColor = UIColor(red:0.0, green: 0.51, blue: 0.0, alpha: 1.0)
        nameField.backgroundColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 0.8)
        ageField.backgroundColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 0.8)
        contactImage.image = UIImage(named: "friendIcon")
        nameField.delegate = self
        ageField.delegate = self
    }
    
    // Dismiss keyboard when user clicks return button on keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false;
    }
    
    // Dismiss keyboard when user touches outside the text fields
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    // Set contact as friend or enemy
    @IBAction func friendEnemyButton(sender: UISegmentedControl) {
        if friendEnemyController.selectedSegmentIndex == 0 {
            friendEnemyController.tintColor = UIColor(red:0.0, green: 0.51, blue: 0.0, alpha: 1.0)
            view.backgroundColor = UIColor(red:0.8, green: 1.0, blue: 0.8, alpha: 1.0)
            contactImage.image = UIImage(named: "friendIcon")
        } else {
            friendEnemyController.tintColor = UIColor(red:0.99, green: 0.16, blue: 0.11, alpha: 1.0)
            view.backgroundColor = UIColor(red:1.0, green: 0.8, blue: 0.8, alpha: 1.0)
            contactImage.image = UIImage(named: "enemyIcon")
        }
    }
}
