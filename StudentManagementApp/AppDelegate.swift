//
//  AppDelegate.swift
//  StudentManagementApp
//
//  Created by Test on 26/10/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "StudentManagementApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    
    func addStudent (firstName: String, lastName: String, gender: String, course: String, age: Int, address: String) {
        let context = getContext()
        //retrieve the entity that we just created
        let entity = NSEntityDescription.entity(forEntityName: "Student", in:
            context)
        let studentUUID = UUID().uuidString;
        
        let transc = NSManagedObject(entity: entity!, insertInto: context)
        //set the entity values
        transc.setValue(studentUUID, forKey: "studentId");
        transc.setValue(firstName, forKey: "firstName");
        transc.setValue(lastName, forKey: "lastName");
        transc.setValue(gender, forKey: "gender");
        transc.setValue(course, forKey: "course");
        transc.setValue(age, forKey: "age");
        transc.setValue(address, forKey: "address");
        //save the object
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    
    func getStudents () -> [String] {
        var students: [String] = []
        //create a fetch request, telling it about the entity
        let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
        do {
            //go get the results
            let searchResults = try getContext().fetch(fetchRequest)
            //You need to convert to NSManagedObject to use 'for' loops
            for trans in searchResults as [NSManagedObject] {
                let studentId = String(trans.value(forKey: "studentId") as! String )
                let firstName = String(trans.value(forKey: "firstName") as! String)
                let lastName = trans.value(forKey: "lastName") as! String
    
                students.append("\(studentId) \(firstName) \(lastName)")
            }
        } catch {
            print("Error with request: \(error)")
        }
        return students;
    }

    func findStudent(studentId: String) -> StudentDateSource {
        
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Student");
        
        userFetch.predicate = NSPredicate(format: "studentId = %@", studentId);
        
        let student = try! getContext().fetch(userFetch);
        let s: Student = student.first as! Student
        
        let studentDataSource = StudentDateSource(studentId: s.studentId!, firstName: s.firstName!, lastName: s.lastName!, gender: s.gender!, course: s.course!, age: s.age, address: s.address!);

        return studentDataSource;
    }
    
    
    func editStudent(studentId: String, firstName: String, lastName: String, gender: String, course: String, age: Int16, address: String) {
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Student");
        
        userFetch.predicate = NSPredicate(format: "studentId = %@", studentId);
        
        let student = try! getContext().fetch(userFetch);
        let s: Student = student.first as! Student
        
        s.firstName = firstName;
        s.lastName = lastName;
        s.gender = gender;
        s.course = course;
        s.age = age;
        s.address = address;
        
        //save the object
        do {
            try getContext().save()
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func deleteStudent(studentId: String) {
        let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest();
        
        fetchRequest.predicate = NSPredicate(format: "studentId = %@", studentId);
        
        let objects = try! getContext().fetch(fetchRequest);
        
        for obj in objects {
            getContext().delete(obj)
        }
        
        do {
            try getContext().save() // <- remember to put this :)
        } catch {
            print("Error: Deleting did not save");
        }
    }
    
    
    func addExam(studentId: String, name: String, dateTime: Date, location: String) {
        
        let context = getContext();
        //retrieve the entity that we just created
        let entity = NSEntityDescription.entity(forEntityName: "Exam", in:
            context)
        let examUUID = UUID().uuidString;
        
        let transc = NSManagedObject(entity: entity!, insertInto: context)
        //set the entity values
        transc.setValue(examUUID, forKey: "examId");
        transc.setValue(studentId, forKey: "studentId");
        transc.setValue(name, forKey: "name");
        transc.setValue(dateTime, forKey: "dateTime");
        transc.setValue(location, forKey: "location");
        
        //save the object
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    
    
    func getExams(studentId: String) -> [ExamDataSource]{
        
        let examFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Exam");
        
        examFetch.predicate = NSPredicate(format: "studentId = %@", studentId);
        
        let fetchExams = try! getContext().fetch(examFetch);
        
        var exams: [ExamDataSource] = []
        
        for trans in fetchExams as! [NSManagedObject] {
            let examId = trans.value(forKey: "examId") as! String;
            let name = trans.value(forKey: "name") as! String;
            let dateTime = trans.value(forKey: "dateTime") as! Date;
            let location = trans.value(forKey: "location") as! String;
            
            exams.append(ExamDataSource(examId: examId, name: name, dateTime: dateTime, location: location));
        }
        
        return exams;
    }
    
    
    func getExam(examId: String) -> ExamDataSource {
        let examFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Exam");
        
        examFetch.predicate = NSPredicate(format: "examId = %@", examId);
        
        let fetchExams = try! getContext().fetch(examFetch);
        
        var exams: ExamDataSource!
        
        for trans in fetchExams as! [NSManagedObject] {
            let examId = trans.value(forKey: "examId") as! String;
            let name = trans.value(forKey: "name") as! String;
            let dateTime = trans.value(forKey: "dateTime") as! Date;
            let location = trans.value(forKey: "location") as! String;
            
            exams = ExamDataSource(examId: examId, name: name, dateTime: dateTime, location: location);
        }
        
        return exams!;
    }
    
    func editExam(examId: String, name: String, dateTime: Date, location: String) {
        let examFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Exam");
        
        examFetch.predicate = NSPredicate(format: "examId = %@", examId);
        
        let student = try! getContext().fetch(examFetch);
        let e: Exam = student.first as! Exam
        
        e.name = name;
        e.dateTime = dateTime;
        e.location = location;
        
        //save the object
        do {
            try getContext().save()
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func deleteExam(examId: String) {
        let fetchRequest: NSFetchRequest<Exam> = Exam.fetchRequest();
        
        fetchRequest.predicate = NSPredicate(format: "examId = %@", examId);
        
        let objects = try! getContext().fetch(fetchRequest);
        
        for obj in objects {
            getContext().delete(obj)
        }
        
        do {
            try getContext().save() // <- remember to put this :)
        } catch {
            print("Error: Deleting did not save");
        }
    }
}
