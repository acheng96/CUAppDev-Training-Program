//
//  EditDetailViewController.swift
//  Project #5 (CUAppDev)
//
//  Created by Annie Cheng on 1/8/15.
//  Copyright (c) 2015 Annie Cheng. All rights reserved.
//

import UIKit

class EditDetailViewController: UIViewController, UITextFieldDelegate {

    // Outlets
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var emailField: UITextField!

    
    // Variable declarations
    var firstName = ""
    var lastName = ""
    var phone = ""
    var email = ""
    
    // When view loads for the first time
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        firstNameField.delegate = self
        lastNameField.delegate = self
        phoneField.delegate = self
        emailField.delegate = self
        firstNameField.backgroundColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 0.8)
        lastNameField.backgroundColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 0.8)
        phoneField.backgroundColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 0.8)
        emailField.backgroundColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 0.8)
    }
    
    // Before the view appears each time
    override func viewWillAppear(animated: Bool) {
        firstNameField.text = firstName
        lastNameField.text = lastName
        phoneField.text = phone
        emailField.text = email
    }

    // Pass data from EditDetailViewController to DetailViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "saveSegue" {
            let detailVC = segue.destinationViewController as! DetailViewController
            detailVC.firstName = firstNameField.text!
            detailVC.lastName = lastNameField.text!
            detailVC.phone = phoneField.text!
            detailVC.email = emailField.text!
        }
    }
    
    // Dismiss keyboard when user clicks return button on keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false;
    }
    
    // Dismiss when user touches outside the text fields
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

}
