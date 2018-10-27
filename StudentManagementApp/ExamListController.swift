//
//  ExamListController.swift
//  StudentManagementApp
//
//  Created by Test on 26/10/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class ExamListController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var studentId: String = "";
    var exams: [ExamDataSource]!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        exams = getExams(studentId: studentId);
        
        tableView.dataSource = self;
        tableView.delegate = self;
    }
    
    func getExams(studentId: String) ->[ExamDataSource] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        
        return appDelegate.getExams(studentId: studentId);
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exams.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = exams[indexPath.row].name
        return cell;
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt
        indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil);
        
        let ExamEditController = storyBoard.instantiateViewController(withIdentifier: "ExamEditController") as! ExamEditController;
        
        //        ExamListController.hello = students[indexPath.row];
        ExamEditController.examId = exams[indexPath.row].examId;
        self.navigationController?.pushViewController(ExamEditController, animated: false)
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
