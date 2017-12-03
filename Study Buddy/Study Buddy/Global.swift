//
//  Global.swift
//  Study Buddy
//
//  Created by Clarissa Jiminian on 12/2/17.
//  Copyright © 2017 Clarissa Jiminian. All rights reserved.
//

import Foundation

final class Global {
    
    static var sharedInstance = Global()
    
    private var user = ""
    
    func setUser(_ name: String) {
        user = name
    }
    
    func getUser() -> String {
        return user
    }
}
