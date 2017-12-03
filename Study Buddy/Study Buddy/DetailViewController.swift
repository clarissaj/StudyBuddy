//
//  DetailViewController.swift
//  Study Buddy
//
//  Created by Clarissa Jiminian on 12/2/17.
//  Copyright © 2017 Clarissa Jiminian. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var selectedRoom: Room?
    var joined = false
    
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var studentCountLabel: UILabel!
    @IBOutlet var joinButton: UIButton!
    @IBOutlet var leaveButton: UIButton!
    @IBOutlet var hostLabel: UILabel!
    
    @IBAction func joinPressed(_ sender: UIButton) {
        if !joined {
            selectedRoom!.studentCount += 1
            studentCountLabel.text = String(selectedRoom!.studentCount)
            joined = true
        } else {
            let action = UIAlertAction(title: "OK", style: .default)
            
            let alert = UIAlertController(title: "Alert", message: "You have already joined this study room.", preferredStyle: .alert)
            
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
    
    @IBAction func leavePressed(_ sender: UIButton) {
        if joined {
            selectedRoom!.studentCount -= 1
            studentCountLabel.text = String(selectedRoom!.studentCount)
            joined = false
            _ = navigationController?.popViewController(animated: true)
        } else {
            let action = UIAlertAction(title: "OK", style: .default)
            
            let alert = UIAlertController(title: "Alert", message: "You have already left this study room.", preferredStyle: .alert)
            
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
    
    override func loadView() {
        super.loadView()
        
        joinButton.layer.cornerRadius = 5
        joinButton.layer.borderWidth = 1
        joinButton.layer.borderColor = UIColor.black.cgColor
        
        leaveButton.layer.cornerRadius = 5
        leaveButton.layer.borderWidth = 1
        leaveButton.layer.borderColor = UIColor.black.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let testRoom = selectedRoom {
            locationLabel.text = testRoom.location
            studentCountLabel.text = String(testRoom.studentCount)
            hostLabel.text = testRoom.username
            navigationItem.title = testRoom.course
        }
        
    }
    
}
