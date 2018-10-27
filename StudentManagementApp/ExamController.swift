//
//  ExamController.swift
//  StudentManagementApp
//
//  Created by Test on 26/10/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class ExamController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var students: [String] = [];

    override func viewDidLoad() {
        super.viewDidLoad()

        print(getStudents());
        students = getStudents();
        // Do any additional setup after loading the view.
        tableView.delegate = self;
        tableView.dataSource = self;
    }
    
    
    func getStudents() -> [String] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.getStudents();
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell =
            tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = students[indexPath.row]
        return cell;
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt
        indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil);
        
        let ExamListController = storyBoard.instantiateViewController(withIdentifier: "ExamListController") as! ExamListController;
        
//        ExamListController.hello = students[indexPath.row];
        ExamListController.studentId = students[indexPath.row].components(separatedBy: " ")[0]
        self.navigationController?.pushViewController(ExamListController, animated: false)
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
