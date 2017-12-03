//
//  CreateRoomViewController.swift
//  Study Buddy
//
//  Created by Clarissa Jiminian on 12/2/17.
//  Copyright © 2017 Clarissa Jiminian. All rights reserved.
//

import UIKit

class CreateRoomViewController : UIViewController, UITextFieldDelegate {
    
    let global = Global.sharedInstance
    
    @IBOutlet var courseField: UITextField!
    @IBOutlet var locationField: UITextField!
    @IBOutlet var createButton: UIButton!
    
    @IBAction func createPressed(_ sender: UIButton) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let room = Room(context : context)
        
        room.location = locationField.text
        room.course = courseField.text
        room.username = global.getUser()
        
        //save to core data
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        //clear textfields
        locationField.text = ""
        courseField.text = ""
        
        //pop
        self.tabBarController?.selectedIndex = 1
    }
    
    override func loadView() {
        super.loadView()
            
        createButton.layer.cornerRadius = 5
        createButton.layer.borderWidth = 1
        createButton.layer.borderColor = UIColor.black.cgColor
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //Clear first responder
        view.endEditing(true)
    }
    
    
}
