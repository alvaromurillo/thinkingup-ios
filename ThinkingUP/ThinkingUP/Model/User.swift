//
//  User.swift
//  ThinkingUP
//
//  Created by Álvaro Murillo del Puerto on 22/1/17.
//  Copyright © 2017 NSCoder Sevilla. All rights reserved.
//

import UIKit

class User: NSObject {
    
    let name: String
    let userId: Int

    init(userId: Int, name: String) {
        
        self.userId = userId
        self.name = name
    }
}
