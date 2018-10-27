//
//  ExamEditController.swift
//  StudentManagementApp
//
//  Created by Test on 26/10/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class ExamEditController: UIViewController {
    
    @IBOutlet weak var dateTime: UIDatePicker!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var location: UITextField!
    var examId: String!;
    var exam: ExamDataSource!;
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fillExam(examId: examId!);
        name.text = exam.name;
        dateTime.date = exam.dateTime
        location.text = exam.location;
    }
    
    @IBAction func deleteHandler(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        appDelegate.deleteExam(examId: examId);
    
    }
    
    
    func fillExam(examId: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        
        exam = appDelegate.getExam(examId: examId);
    }
  
    @IBAction func editHandler(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        
        appDelegate.editExam(examId: examId!, name: name.text!, dateTime: dateTime.date, location: location.text!)
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
