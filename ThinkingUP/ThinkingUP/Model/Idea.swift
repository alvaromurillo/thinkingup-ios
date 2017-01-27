//
//  Idea.swift
//  ThinkingUP
//
//  Created by Álvaro Murillo del Puerto on 22/1/17.
//  Copyright © 2017 NSCoder Sevilla. All rights reserved.
//

import UIKit

class Idea: NSObject {

    let title: String
    let ideaDescription: String
    let user: User
    
    init(title: String, ideaDescription: String, user: User) {
        
        self.title = title
        self.ideaDescription = ideaDescription
        self.user = user
    }
}
