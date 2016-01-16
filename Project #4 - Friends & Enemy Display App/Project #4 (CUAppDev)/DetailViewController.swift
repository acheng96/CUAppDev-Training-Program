//
//  DetailViewController.swift
//  Project #4 (CUAppDev)
//
//  Created by Annie Cheng on 1/7/15.
//  Copyright (c) 2015 Annie Cheng. All rights reserved.
//

import UIKit

// Protocol
protocol DetailViewControllerDelegate {
    func myVCDidUpdateName(controller:DetailViewController,text:String)
    func myVCDidUpdateAge(controller:DetailViewController,text:String)
}

class DetailViewController: UIViewController, UITextFieldDelegate {

    // Outlets
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var contactImage: UIImageView!

    // Variable declarations
    var delegate: DetailViewControllerDelegate? = nil
    var name = ""
    var age = ""
    var bColor = UIColor()
    var labelColor = UIColor()
    var contact = ""
    
    // When view loads for the first time
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nameField.backgroundColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 0.8)
        ageField.backgroundColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 0.8)
        if contact == "friend" {
            contactImage.image = UIImage(named: "friendIcon")
        } else {
            contactImage.image = UIImage(named: "enemyIcon")
        }
        
        nameField.delegate = self
        ageField.delegate = self
    }
    
    // Before the view appears each time
    override func viewWillAppear(animated: Bool) {
        statusLabel.text = "Edit contact's information"
        statusLabel.textColor = labelColor
        nameField.text = name
        ageField.text = age
        view.backgroundColor = bColor
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
    
    // Save changes and passes data to table view in main view controller
    @IBAction func saveChangesButton(sender: UIButton) {
        statusLabel.text = "Changes saved!"
        statusLabel.textColor = UIColor(red: 0.1, green: 0.9, blue: 0.9, alpha: 0.5)
        statusLabel.shadowColor = UIColor.blackColor()
        if (delegate != nil) {
            delegate!.myVCDidUpdateName(self, text: nameField!.text!)
            delegate!.myVCDidUpdateAge(self, text: ageField!.text!)
        }
    }
}
