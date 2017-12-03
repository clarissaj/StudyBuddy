//
//  LoginViewController.swift
//  Study Buddy
//
//  Created by Clarissa Jiminian on 12/2/17.
//  Copyright © 2017 Clarissa Jiminian. All rights reserved.
//

import UIKit

class LoginViewController : UIViewController {
    
    var students: [Student] = []
    let global = Global.sharedInstance
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var exists = false
    
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var pwField: UITextField!
    
    
    
    @IBAction func loginPressed(_ sender: UIButton)
    {
        
        if usernameField.text != "" || pwField.text != ""
        {
            
            for student in students
            {
                if student.username == usernameField.text
                {
                    if student.password == pwField.text
                    {
                        //clear fields
                        usernameField.text = ""
                        pwField.text = ""
                        
                        self.tabBarController?.selectedIndex = 1
                        global.setUser(student.username!)
                        
                    }
                    else
                    {
                        let action = UIAlertAction(title: "OK", style: .default)
                        
                        let alert = UIAlertController(title: "Invalid Password", message: "You have entered an invalid password.", preferredStyle: .alert)
                        
                        alert.addAction(action)
                        present(alert, animated: true)
                    }
                }
                else
                {
                    let action = UIAlertAction(title: "OK", style: .default)
                    
                    let alert = UIAlertController(title: "Invalid Username", message: "You have entered an invalid username.", preferredStyle: .alert)
                    
                    alert.addAction(action)
                    present(alert, animated: true)
                }
            }
        }
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if usernameField.text != nil || pwField.text != nil {
            for student in students {
                if student.username == usernameField.text {
                    exists = true
                    break
                }
            }
            
            if exists {
                let action = UIAlertAction(title: "OK", style: .default)
                
                let alert = UIAlertController(title: "Error", message: "Username already exists.", preferredStyle: .alert)
                
                alert.addAction(action)
                present(alert, animated: true)
            } else { //register
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                let student = Student(context : context)
                
                student.username = usernameField.text
                student.password = pwField.text
                
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
                
                self.tabBarController?.selectedIndex = 1
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        
        if global.getUser() != "" {
            if let arrayOfTabBarItems = tabBarController?.tabBar.items as AnyObject as? NSArray,let tabBarItem = arrayOfTabBarItems[0] as? UITabBarItem { tabBarItem.isEnabled = false }
        } else {
            if let arrayOfTabBarItems = tabBarController?.tabBar.items as AnyObject as? NSArray,let tabBarItem = arrayOfTabBarItems[2] as? UITabBarItem { tabBarItem.isEnabled = false }
        }
    }
    
    func getData() {
        do {
            students = try context.fetch(Student.fetchRequest())
        } catch {
            print ("Fetching Failed")
        }
        
    }

}
