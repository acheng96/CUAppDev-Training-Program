//
//  ViewController.swift
//  Project #1 (CUAppDev)
//
//  Created by Annie Cheng on 1/5/15.
//  Copyright (c) 2015 Annie Cheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, SecretViewControllerDelegate {
    
    // Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var controlSwitch: UISwitch!
    @IBOutlet weak var scroll: UIImageView!
    @IBOutlet weak var lock: UIImageView!
    @IBOutlet weak var revealSecretButton: UIButton!
    
    // Variable declarations
    var username: String! = "username"
    var password: String! = "password"
    var secretMessage: String! = "Hello! This is the secret message!"
    
    // Protocol for username change
    func myVCDidUpdateUsername(controller: SecretViewController, text: String) {
        username = text
    }
    
    // Protocol for password change
    func myVCDidUpdatePassword(controller: SecretViewController, text: String) {
        password = text
    }
    
    // Protocol for secret message change
    func myVCDidUpdateSecretMessage(controller:SecretViewController,text:String) {
        secretMessage = text
    }
    
    // When view loads for the first time
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        usernameField.delegate = self
    }
    
    // Before the view loads each time
    override func viewWillAppear(animated: Bool) {
        usernameField.backgroundColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 0.8)
        passwordField.backgroundColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 0.8)
        lock.image  = UIImage(named: "locked")
        message.hidden = true
        controlSwitch.on = false
        revealSecretButton.hidden = true
    }
    
    // Pass data from ViewController to SecretViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "revealSecret" {
            let secretVC = segue.destinationViewController as SecretViewController
            if var user = secretVC.newUsernameField {
                user.text = username
            }
            if var pass = secretVC.newPasswordField {
                pass.text = password
            }
            secretVC.newSecretMessage = secretMessage
            secretVC.delegate = self
        }
    }
    
    // Deallocate recreatable assets at critically low memory levels
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Hide keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    // Respond when user touches outside the text fields
    override func touchesBegan(touches: (NSSet!), withEvent event: UIEvent) {
        self.view.endEditing(true)
    }

//<----------------- HELPER FUNCTIONS ---------------->
    
    // Reveal error message when username or password is incorrect
    func revealErrorMessage() {
        lock.image  = UIImage(named: "locked")
        message.text = "Incorrect username\nor password :(\nTry again!"
        message.textColor = UIColor.redColor()
        message.font = UIFont(name: "Cochin-BoldItalic", size: 25)
    }
    
    // Reveal password if switch is on and username or password is incorrect
    func revealPassword() {
        lock.image  = UIImage(named: "locked")
        message.text = "Hint:\nThe password is\n" + "'" + password + "'" + "."
        message.font = UIFont(name: "Cochin-BoldItalic", size: 25)
        message.textColor = UIColor(red: 1.0, green: 0.8, blue: 0.4, alpha: 0.5)
    }
    
    // Reveal secret message if username and password are correct
    func revealSecretMessage() {
        lock.image  = UIImage(named: "unlocked")
        message.text = "Congrats :)\nYou unlocked the\nsecret message!"
        message.textColor = UIColor(red: 0.1, green: 0.9, blue: 0.9, alpha: 0.5)
        usernameField.backgroundColor = UIColor(red: 0.8, green: 1.0, blue: 0.8, alpha: 0.5)
        message.shadowColor = UIColor.blackColor()
        passwordField.backgroundColor = UIColor(red: 0.8, green: 1.0, blue: 0.8, alpha: 0.5)
        message.font = UIFont(name: "Cochin-BoldItalic", size: 25)
        revealSecretButton.hidden = false
    }
    
    // Reveal message based on whether switch is on or off
    func checkSwitch() {
        if controlSwitch.on { // Reveals password
            revealPassword()
        } else {
            revealErrorMessage()
        }
    }
    
    // Clear text in username and password text fields.
    func clearInput(){
        usernameField.text = ""
        passwordField.text = ""
    }
    
//<----------------- BUTTONS ---------------->
    
    // Reveal secret message, error message, or password.
    @IBAction func revealMessage(sender: UIButton) {
        message.hidden = false
        message.shadowColor = UIColor.blackColor()
        switch usernameField.text {
        case username: // Correct username
            switch passwordField.text {
            case password: // Correct username and password
                revealSecretMessage()
            default: // Correct username but incorrect password
                checkSwitch()
            usernameField.backgroundColor = UIColor(red: 0.8, green: 1.0, blue: 0.8, alpha: 0.5)
            passwordField.backgroundColor = UIColor(red: 1.0, green: 0.6, blue: 0.6, alpha: 0.5)
            }
        default: // Incorrect username
            checkSwitch()
            usernameField.backgroundColor = UIColor(red: 1.0, green: 0.6, blue: 0.6, alpha: 0.5)
            switch passwordField.text {
                case password: // Incorrect username but correct password
                    passwordField.backgroundColor = UIColor(red: 0.8, green: 1.0, blue: 0.8, alpha: 0.5)
                default: // Incorrect username and incorrect password
                    passwordField.backgroundColor = UIColor(red: 1.0, green: 0.6, blue: 0.6, alpha: 0.5)
            }
        }
        clearInput() // Clears username and password text fields.
    }
    
    // Perform Segue to SecretViewController
    @IBAction func revealSecret(sender: UIButton) {
        self.performSegueWithIdentifier("revealSecret", sender: nil)
    }
}

