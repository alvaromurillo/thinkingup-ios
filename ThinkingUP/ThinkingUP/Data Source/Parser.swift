//
//  Parser.swift
//  ThinkingUP
//
//  Created by Álvaro Murillo del Puerto on 22/1/17.
//  Copyright © 2017 NSCoder Sevilla. All rights reserved.
//

import UIKit

class Parser: NSObject {

    static func userFromDict(dict: [String: Any]) -> User {
        
        let name = dict["name"] as? String ?? ""
        let userId = dict["id"] as? Int ?? 0
        
        return User.init(userId: userId, name: name)
    }
    
    static func ideaFromDict(dict: [String: Any]) -> Idea {
        
        let title = dict["title"] as? String ?? ""
        let ideaDescription = dict["description"] as? String ?? ""
        var user: User
        if let userDict: [String: Any] = dict["user"] as? [String : Any] {
            user = userFromDict(dict: userDict)
        } else {
            user = User.init(userId: 0, name: "")
        }
        
        return Idea.init(title: title, ideaDescription: ideaDescription, user: user)
    }
}
