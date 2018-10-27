//
//  StudentAddController.swift
//  StudentManagementApp
//
//  Created by Test on 26/10/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class StudentAddController: UIViewController {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var course: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var address: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func create(_ sender: Any) {
        // get the AppDelegate object
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // call function storePersonInfo in AppDelegate
        
        appDelegate.addStudent(firstName: firstName.text!, lastName: lastName.text!, gender: gender.text!, course: course.text!, age: Int(age.text!)!, address: address.text!);
        
        
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
