//
//  Student.swift
//  Project #2 (CUAppDev)
//
//  Created by Annie Cheng on 1/5/15.
//  Last updated: 1/6/15
//  Copyright (c) 2015 Annie Cheng. All rights reserved.
//

import Foundation

class Student: NSObject {
    
    // Variable declarations
    var name: String!
    var year: Int!
    var major: String!
    var gpa: Double!
    var birthDate: String!
    
    // Constructor
    init(name: String!, year: Int!, major: String!, gpa: Double!, birthDate: String!) {
        self.name = name
        self.year = year
        self.major = major
        self.gpa = gpa
        self.birthDate = birthDate
    }

    // Student description to be displayed in StudentInfoView
    override var description: String {
        return "\(name) (Born on \(birthDate); Class of \(year)) is majoring in \(major) with a \(gpa)"
    }
}