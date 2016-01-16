
//
//  TableViewController.swift
//  Project #5 (CUAppDev)
//
//  Created by Annie Cheng on 1/7/15.
//  Copyright (c) 2015 Annie Cheng. All rights reserved.
//

import UIKit

let JSON_URL = "https://raw.githubusercontent.com/cuappdev/trainingProgramResources/master/Lecture5JSON.json"

class TableViewController: UITableViewController, UIPopoverPresentationControllerDelegate {
    
    // Initialize array of people
    var people: [Person] = []
    var firstName = ""
    var lastName = ""
    var phone = ""
    var email = ""
    var emailArray = []
    var row: Int!
    let jsonData: NSData = NSData(contentsOfURL: NSURL(string: JSON_URL)!)!

    // When view loads for the first time
    override func viewDidLoad() {
        super.viewDidLoad()

        appendPeople()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: Selector("didRefreshData"), forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "background"))
        tableView.rowHeight = 100.0
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
    }
    
    // Before view loads each time
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    // Append people from json file
    func appendPeople() {
        if let jsonResult = (try? NSJSONSerialization.JSONObjectWithData(jsonData, options: [])) as? Array<AnyObject> {
            for i in jsonResult {
                var email: [String]
                if let e = i["email"] as? [String] {
                    email = e
                } else {
                    email = [i["email"] as! String]
                }
                let person: Person = Person(
                    fname: i["fname"] as! String,
                    lname: i["lname"] as! String,
                    phone: i["phone"] as! String,
                    email: email
                )
                people.append(person)
            }
        }
    }
    
    // Refresh data in table view
    func didRefreshData() {
        appendPeople()
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
    // Pass data to DetailViewController using segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailSegue" {
            let detailVC = segue.destinationViewController as! DetailViewController
            row = tableView.indexPathForSelectedRow?.row
            detailVC.firstName = people[row!].fname
            detailVC.lastName = people[row!].lname
            detailVC.phone = people[row!].phone
            for e in people[row!].email {
                detailVC.email += e
                if e != people[row!].email.last {
                    detailVC.email += ", "
                }
            }
            detailVC.contactImage?.image = UIImage(named: "personIcon")
        }
    }
    
    // Return to main view controller from DetailViewController
    @IBAction func unwindToMainVC(segue: UIStoryboardSegue) {
        let detailVC = segue.sourceViewController as! DetailViewController
        firstName = detailVC.firstName
        lastName = detailVC.lastName
        phone = detailVC.phone
        email = detailVC.email
        emailArray = email.componentsSeparatedByString(", ")
        let person: Person = Person(
            fname: firstName as String,
            lname: lastName as String,
            phone: phone as String,
            email: emailArray as! [String]
        )
        people[row!] = person
    }
    
    // MARK: - Table view data source
    
    // Number of sections
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // Number of rows
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    // Configure cell data
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TableViewCell
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor.clearColor()
        } else {
            cell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.1)
            cell.nameLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
            cell.phoneLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
            cell.emailLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
        }
        
        cell.nameLabel?.textColor = UIColor.whiteColor()
        cell.phoneLabel?.textColor = UIColor.whiteColor()
        cell.emailLabel?.textColor = UIColor.whiteColor()
        
        let currentPerson = people[indexPath.row]
        cell.nameLabel.text = currentPerson.fullName
        cell.phoneLabel.text = currentPerson.phone
        
        var email: String = ""
        for e in currentPerson.email {
            email += e
            if e != currentPerson.email.last {
                email += ", "
            }
        }
        
        cell.emailLabel.text = email
        cell.contactImageView.image = UIImage(named: "personIcon")
        cell.phoneImage.image = UIImage(named: "phoneIcon")
        cell.emailImage.image = UIImage(named: "emailIcon")
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(red:0.1, green: 0.1, blue: 0.1, alpha: 0.2)
        cell.selectedBackgroundView = bgColorView
        
        return cell
    }
    
    // Remove contact using swipe-delete mechanism
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            people.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
}