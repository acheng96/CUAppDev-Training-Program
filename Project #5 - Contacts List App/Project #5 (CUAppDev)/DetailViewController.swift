//
//  DetailViewController.swift
//  Project #5 (CUAppDev)
//
//  Created by Annie Cheng on 1/8/15.
//  Copyright (c) 2015 Annie Cheng. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // Outlets
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    // Variable declarations
    var firstName = ""
    var lastName = ""
    var phone = ""
    var email = ""
    
    // When view loads for the first time
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // When view loads each time
    override func viewWillAppear(animated: Bool) {
        nameLabel.text = firstName + " " + lastName
        phoneLabel.text = phone
        emailLabel.text = email
    }
    
    // Pass data to EditDetailViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "EditModeSegue" {
            let editDetailVC = segue.destinationViewController as! EditDetailViewController
            editDetailVC.firstName = firstName
            editDetailVC.lastName = lastName
            editDetailVC.phone = phoneLabel.text!
            editDetailVC.email = emailLabel.text!
        }
    }
    
    // Return to DetailViewController from EditDetailViewController
    @IBAction func unwindToDetailVC(sender: UIStoryboardSegue) {
    }
    
}
