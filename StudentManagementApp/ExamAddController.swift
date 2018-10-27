//
//  ExamAddController.swift
//  StudentManagementApp
//
//  Created by Test on 26/10/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class ExamAddController: UIViewController {

    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var location: UITextField!
    
    var studentId: String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func create(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        
        appDelegate.addExam(studentId: studentId, name: name.text!, dateTime: date.date, location: location.text!);
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
