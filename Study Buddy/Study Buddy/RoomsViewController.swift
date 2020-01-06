//
//  RoomsViewController.swift
//  Study Buddy
//
//  Created by Clarissa Jiminian on 12/2/17.
//  Copyright © 2017 Clarissa Jiminian. All rights reserved.
//

import UIKit

class RoomsViewController: UITableViewController {
    
    let global = Global.sharedInstance
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var rooms: [Room] = []
    
    //checks for rows needed to display in tableview
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count
    }
    
    //sets details to display each row/cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomCell", for: indexPath)
        
        let room = rooms[indexPath.row]
        
        cell.textLabel?.text = room.course
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let room = rooms[indexPath.row]
            context.delete(room)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
                rooms = try context.fetch(Room.fetchRequest())
            } catch {
                print("Fetching Failed")
            }
        }
        
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getData()
        tableView.reloadData()
        
        if global.getUser() != "" {
            if let arrayOfTabBarItems = tabBarController?.tabBar.items as AnyObject as? NSArray,let tabBarItem = arrayOfTabBarItems[2] as? UITabBarItem { tabBarItem.isEnabled = true }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //If the triggered segue is the "ShowDetail" segue
        switch segue.identifier {
        case "ShowDetail"?:
            //Figure out which row was just tapped
            if let row = tableView.indexPathForSelectedRow?.row
            {
                //Get the room associated with this row and pass it along
                let room = rooms[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.selectedRoom = room
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
    
    func getData() {
        do {
            rooms = try context.fetch(Room.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
    }
}
