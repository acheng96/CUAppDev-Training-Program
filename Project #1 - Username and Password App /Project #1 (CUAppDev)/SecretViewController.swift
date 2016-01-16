//
//  SecretViewController.swift
//  Project #1 (CUAppDev)
//
//  Created by Annie Cheng on 1/5/15.
//  Last updated: 1/5/15
//  Copyright (c) 2015 Annie Cheng. All rights reserved.
//

import UIKit

// Protocol
protocol SecretViewControllerDelegate{
    func myVCDidUpdateUsername(controller:SecretViewController,text:String)
    func myVCDidUpdatePassword(controller:SecretViewController,text:String)
    func myVCDidUpdateSecretMessage(controller:SecretViewController,text:String)
}

class SecretViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    // Outlets
 
    @IBOutlet weak var secretMessage: UITextView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var newUsernameField: UITextField!
    @IBOutlet weak var newPasswordField: UITextField!
    @IBOutlet weak var secretMessageView: UITextView!
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var updateButton: UIButton!
    
    // Variable declarations
    var delegate:SecretViewControllerDelegate? = nil
    var newSecretMessage: String!
    
    // When view loads for the first time
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newUsernameField.delegate = self
        newPasswordField.delegate = self
        secretMessageView.delegate = self
    }
    
    // Before view loads each time
    override func viewWillAppear(animated: Bool) {
        newUsernameField.backgroundColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 0.8)
        newPasswordField.backgroundColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 0.8)
        secretMessageView.backgroundColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 0.8)
        statusLabel.text = "Want to mix things up?"
        secretMessage.text = newSecretMessage
        secretMessageView.text = newSecretMessage
    }

    // Deallocate recreatable assets at critically low memory levels
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Dismiss keyboard when user clicks return button on keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    // Dismiss when user touches outside the text fields
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Clear text in new username and password text fields.
    func clearTextFieldInput() {
        newUsernameField.text = ""
        newPasswordField.text = ""
    }
    
//<----------------- BUTTONS ---------------->

    // Button to change username and password
    @IBAction func changeUserAndPassButton(sender: UIButton) {
        if (delegate != nil) {
            delegate!.myVCDidUpdateUsername(self, text: newUsernameField!.text!)
            delegate!.myVCDidUpdatePassword(self, text: newPasswordField!.text!)
        }
        statusLabel.text = "Access info successfully changed"
        statusLabel.textColor = UIColor(red: 0.15, green: 0.28, blue: 0.43, alpha: 1.0)
        statusLabel.font = UIFont(name: "Cochin-BoldItalic", size: 20)
        clearTextFieldInput()
    }

    // Button to update secret message
    @IBAction func updateSecretMessageButton(sender: UIButton) {
        secretMessage.text = secretMessageView.text
        if (delegate != nil) {
            delegate!.myVCDidUpdateSecretMessage(self,text: secretMessage!.text!)
        }
    }

}
