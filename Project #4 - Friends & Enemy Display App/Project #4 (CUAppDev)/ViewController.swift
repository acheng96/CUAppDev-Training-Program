//
//  ViewController.swift
//  Project #4 (CUAppDev)
//
//  Created by Annie Cheng on 1/7/15.
//  Copyright (c) 2015 Annie Cheng. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DetailViewControllerDelegate {

    // Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // Variable declarations
    var friendNames = ["Betty", "Gaby", "Helen", "Jessica", "Joanne", "Tiffany"]
    var friendAges = ["18", "18", "18", "18", "18", "18"]
    var enemyNames = ["Billy", "Bob", "Joe", "Jenny", "Molly", "Meredith"]
    var enemyAges = ["18", "18", "18", "18", "18", "18"]
    var row: Int!
    var newName: String!
    var newAge: String!
    
    // When view loads for the first time
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // Before view loads every time
    override func viewWillAppear(animated: Bool) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRowAtIndexPath(indexPath, animated: false)
        }
        tableView.reloadData()
    }
    
    //var assets = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: nil)
    
    // Define two sections in table view
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       return 2
    }

    // Define titles for different sections
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Friends"
        } else {
            return "Enemies"
        }
    }

    // Return number of rows in table view
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return friendNames.count
        } else {
            return enemyNames.count
        }
    }
    
    // Return cell based on index path
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath)
        -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "Cell")
        if indexPath.section == 0 {
            cell.textLabel?.text = friendNames[indexPath.row] + " is " + friendAges[indexPath.row] + " years old"
            cell.textLabel?.font = UIFont(name: "Heiti SC Medium", size: 15)
            cell.textLabel?.textColor = UIColor(red:0.0, green: 0.51, blue: 0.0, alpha: 1.0)
            cell.backgroundColor = UIColor(red:0.8, green: 1.0, blue: 0.8, alpha: 1.0)
            cell.imageView?.image = UIImage(named: "friendIcon")
        } else {
            cell.textLabel?.text = enemyNames[indexPath.row] + " is " + enemyAges[indexPath.row] + " years old"
            cell.textLabel?.font = UIFont(name: "Heiti SC Medium", size: 15)
            cell.textLabel?.textColor = UIColor(red:0.99, green: 0.16, blue: 0.11, alpha: 1.0)
            cell.backgroundColor = UIColor(red:1.0, green: 0.8, blue: 0.8, alpha: 1.0)
            cell.imageView?.image = UIImage(named: "enemyIcon")
        }
        return cell
    }
    
    // Set even row height to 60 and odd row height to 40
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.row % 2 == 0) {
            return CGFloat(60)
        } else {
            return CGFloat(40)
        }
    }
    
    // Remove contact using swipe-delete mechanism
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    
        if editingStyle == UITableViewCellEditingStyle.Delete {
            if indexPath.section == 0 {
                friendNames.removeAtIndex(indexPath.row)
                friendAges.removeAtIndex(indexPath.row)
            } else {
                enemyNames.removeAtIndex(indexPath.row)
                enemyAges.removeAtIndex(indexPath.row)
            }
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    // Update contact's name
    func myVCDidUpdateName(controller:DetailViewController,text:String) {
        if tableView.indexPathForSelectedRow?.section == 0 {
            friendNames[row] = text
        } else {
            enemyNames[row] = text
        }
        
    }
    
    // Update contact's age
    func myVCDidUpdateAge(controller:DetailViewController,text:String) {
        if tableView.indexPathForSelectedRow?.section == 0 {
            friendAges[row] = text
        } else {
            enemyAges[row] = text
        }
    }
    
    // Send data to DetailViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailSegue" {
            row = tableView.indexPathForSelectedRow?.row
            let vc = segue.destinationViewController as! DetailViewController
            if tableView.indexPathForSelectedRow?.section == 0 {
                vc.name = friendNames[row!]
                vc.age = friendAges[row!]
                vc.bColor = UIColor(red:0.8, green: 1.0, blue: 0.8, alpha: 1.0)
                vc.labelColor = UIColor(red:0.0, green: 0.51, blue: 0.0, alpha: 1.0)
                vc.contact = "friend"
            } else {
                vc.name = enemyNames[row!]
                vc.age = enemyAges[row!]
                vc.bColor = UIColor(red:1.0, green: 0.8, blue: 0.8, alpha: 1.0)
                vc.labelColor = UIColor(red:0.99, green: 0.16, blue: 0.11, alpha: 1.0)
                vc.contact = "enemy"
            }
            vc.delegate = self
        }
    }
    
    // Return to main view controller when cancel button pressed
    @IBAction func cancel(segue: UIStoryboardSegue) {
    }
    
    // Return to main view controller when save button pressed
    @IBAction func save(segue: UIStoryboardSegue) {
        let addContactVC = segue.sourceViewController as! AddContactViewController
        newName = addContactVC.nameField.text
        newAge = addContactVC.ageField.text
        if addContactVC.friendEnemyController.selectedSegmentIndex == 0 {
            friendNames.append(newName)
            friendAges.append(newAge)
        } else {
            enemyNames.append(newName)
            enemyAges.append(newAge)
        }
    }
}










