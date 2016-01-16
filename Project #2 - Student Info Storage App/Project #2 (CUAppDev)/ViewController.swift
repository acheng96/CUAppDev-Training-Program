//
//  ViewController.swift
//  Project #2 (CUAppDev)
//
//  Created by Annie Cheng on 1/5/15.
//  Last updated: 1/6/15
//  Copyright (c) 2015 Annie Cheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    // Outlets
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var yearField: UITextField!
    @IBOutlet weak var majorField: UITextField!
    @IBOutlet weak var gpaField: UITextField!
    @IBOutlet weak var studentInfoView: UITextView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var sortController: UISegmentedControl!
    @IBOutlet weak var birthDateField: UITextField!
    
    // Variable declarations
    var studentDescription: String!
    var datePickerView: UIDatePicker = UIDatePicker()
    
    //Initialize array
    var studentInfo = [Student(name: "NameExample", year: 2018, major: "majorExample", gpa: 4.0, birthDate: "birthDateExample")]
    
    // When view loads for the first time
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set up UIDatePicker for birthDateField
        datePickerView.datePickerMode = UIDatePickerMode.Date
        birthDateField.inputView = datePickerView
        datePickerView.addTarget(self, action: Selector("handleDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)
        
        // UITextField Delegates
        self.nameField.delegate = self
        self.yearField.delegate = self
        self.majorField.delegate = self
        self.gpaField.delegate = self
        
        // Formatting background color of text fields and views
        nameField.backgroundColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 0.8)
        yearField.backgroundColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 0.8)
        majorField.backgroundColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 0.8)
        gpaField.backgroundColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 0.8)
        birthDateField.backgroundColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 0.8)
        studentInfoView.backgroundColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 0.8)
    }

    // Deallocate recreatable assets at critically low memory levels
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//<----------------HELPER FUNCTIONS---------------->
    
    // Called when user input for year or GPA is invalid
    func changeStatusLabel(labelName: String!) {
        statusLabel.text = "Please enter " + labelName
        statusLabel.textColor = UIColor.redColor()
        statusLabel.shadowColor = nil
    }
    
    // Called when student is successfully added to StudentInfoView
    func studentAdded() {
        statusLabel.text = "Student Added!"
        statusLabel.textColor = UIColor(red: 0.1, green: 0.9, blue: 0.9, alpha: 0.5)
        statusLabel.shadowColor = UIColor.blackColor()
    }
    
    // Sort studentInfo based on selected segment index of sortController
    func checkSegmentedControl() {
        if studentInfo.count > 1 {
            if sortController.selectedSegmentIndex == 0 {
                studentInfo.sortInPlace({$0.name < $1.name})
            } else if sortController.selectedSegmentIndex == 1 {
                studentInfo.sortInPlace({$0.year < $1.year})
            } else if sortController.selectedSegmentIndex == 2 {
                studentInfo.sortInPlace({$0.gpa < $1.gpa})
            } else if sortController.selectedSegmentIndex == 3 {
                studentInfo.sortInPlace({$0.gpa > $1.gpa})
            }
        }
    }
    
    // Display sorted list of students
    func displaySortedStudentInfo() {
        // Remove initialized Student example
        for student in studentInfo {
            if student.name == "NameExample" {
                studentInfo.removeAtIndex(0)
            }
        }
        checkSegmentedControl()
        studentInfoView.text = ""
        for student in studentInfo {
            studentDescription = "~ " + "\(student.name) (Born on \(student.birthDate); Class of \(student.year)) is majoring in \(student.major) with a \(student.gpa)\n"
            studentInfoView.text = studentInfoView.text + studentDescription
        }
    }
    
    // Clear all text in text fields
    func clearInput() {
        nameField.text = ""
        yearField.text = ""
        majorField.text = ""
        gpaField.text = ""
        birthDateField.text = ""
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
    
    // Handle the format of the date picker
    func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        birthDateField.text = dateFormatter.stringFromDate(sender.date)
    }
    
//<----------------BUTTONS---------------->
    
    // Allow user to pick birth date with date picker
    @IBAction func datePicker(sender: UITextField) {
        datePickerView.addTarget(self, action: Selector("handleDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    // Sort list of students in studentInfoView based on selected segment index
    @IBAction func sortControlButton(sender: UISegmentedControl) {
        displaySortedStudentInfo()
    }
    
    // Add new student info to studentInfoView
    @IBAction func addStudentButton(sender: UIButton) {
        var name = nameField.text
        let major = majorField.text
        let birthDate = birthDateField.text
        // Ensure nonempty name or major
        if (nameField.text!.isEmpty) || (majorField.text!.isEmpty) || (gpaField.text!.isEmpty) || (birthDateField.text!.isEmpty) {
            changeStatusLabel("information in all fields")
        } else {
            name = name!.substringToIndex(name!.startIndex.advancedBy(1)).uppercaseString + name!.substringFromIndex(name!.startIndex.advancedBy(1))
            let gpa = (gpaField.text! as NSString).doubleValue
            // Validate year
            if let year = Int(yearField.text!) {
                let s = Student(name: name, year: year, major: major, gpa: gpa, birthDate: birthDate)
                // Validate gpa
                if (gpa >= 0.0 && gpa <= 4.33) {
                    studentInfo.append(s)
                    displaySortedStudentInfo()
                    studentAdded()
                    clearInput()
                } else {
                    changeStatusLabel("a valid GPA")
                }
            } else {
                if (gpa >= 0.0 && gpa <= 4.33) {
                    changeStatusLabel("a valid year")
                } else {
                    changeStatusLabel("a valid year and GPA")
                }
            }
        }
    }
}