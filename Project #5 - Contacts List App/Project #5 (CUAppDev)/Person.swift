//
//  Person.swift
//  Project #5 (CUAppDev)
//
//  Created by Annie Cheng on 1/7/15.
//  Copyright (c) 2015 Annie Cheng. All rights reserved.
//

import UIKit

class Person: NSObject {
    
    // Declarations
    let fname: String
    let lname: String
    let phone: String
    let email: [String]
    
    // Constructor
    init(fname: String, lname: String, phone: String, email: [String]) {
        self.fname = fname
        self.lname = lname
        self.phone = phone
        self.email = email
    }
    
    // Person description
    override var description: String {
        return "\nName: \(fname) \(lname)\nPhone: \(phone)\nEmail: \(email)"
    }
    
    // Person's full name
    var fullName: String {
        return "\(fname) \(lname)"
    }
}

