//
//  studentDataSource.swift
//  StudentManagementApp
//
//  Created by Test on 26/10/18.
//  Copyright © 2018 Test. All rights reserved.
//


class StudentDateSource {
    var studentId: String;
    var firstName: String;
    var lastName: String;
    var gender: String;
    var course: String;
    var age: Int16;
    var address: String;
    
    init(studentId: String, firstName: String, lastName: String, gender: String, course: String, age: Int16, address: String) {
        
        self.studentId = studentId;
        self.firstName = firstName;
        self.lastName = lastName;
        self.gender = gender;
        self.course = course;
        self.age = age;
        self.address = address;
        
    }
    
    
}
