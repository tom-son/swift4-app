//
//  ExamDataSource.swift
//  StudentManagementApp
//
//  Created by Test on 26/10/18.
//  Copyright © 2018 Test. All rights reserved.
//

import Foundation;


class ExamDataSource {
    var examId: String;
    var name: String;
    var dateTime: Date;
    var location: String;
    
    init(examId: String, name: String, dateTime: Date, location: String) {
        self.examId = examId;
        self.name = name
        self.dateTime = dateTime;
        self.location = location;
    }
}
