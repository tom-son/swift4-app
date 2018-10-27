//
//  StudentEditController.swift
//  StudentManagementApp
//
//  Created by Test on 26/10/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class StudentEditController: UIViewController {

    var hello: String = "";
    var student: StudentDateSource!;
    var studentId: String!;
    
    
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var course: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var address: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        student = appDelegate.findStudent(studentId: studentId!);
        print("From StudentEditController \(student.studentId)");
        // Do any additional setup after loading the view.
        
        firstName.text = student.firstName;
        lastName.text = student.lastName;
        gender.text = student.gender;
        course.text = student.course;
        age.text = String(student.age);
        address.text = student.address;
        
    }
    
    @IBAction func editHandler(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        appDelegate.editStudent(studentId: studentId, firstName: firstName.text!, lastName: lastName.text!, gender: gender.text!, course: course.text!, age: Int16(age.text!)!, address: address.text!);
        
    }
    
    
    @IBAction func deleteHandler(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        appDelegate.deleteStudent(studentId: studentId);
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
