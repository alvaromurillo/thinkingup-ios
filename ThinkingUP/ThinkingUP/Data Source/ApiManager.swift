//
//  ApiManager.swift
//  ThinkingUP
//
//  Created by Álvaro Murillo del Puerto on 22/1/17.
//  Copyright © 2017 NSCoder Sevilla. All rights reserved.
//

import UIKit
import Alamofire

class ApiManager: NSObject {
    
    var sessionManager: SessionManager?
    
    class func appInstance() -> ApiManager {
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.apiManager
    }

    func doLogin(user: String, password: String, completion: @escaping (_ success: Bool,_ error: Error?) -> Void ) -> Void {
        
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        let parameters = ["client_id": Constants.Server.clientID,
                          "client_secret": Constants.Server.clientSecret,
                          "username": user,
                          "password": password,
                          "grant_type": "password"]
        
        Alamofire.request(Constants.Server.host + "/oauth/v2/token", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response: DataResponse<Any>) in
            
            if let error = response.error {
                
                completion(false, error)
                
            } else if let json = response.result.value as? [String: Any] {
                
                if let accessToken = json["access_token"] as? String,
                    let refreshToken = json["refresh_token"] as? String {
                    
                    let oauthHandler = OAuth2Handler(clientID: Constants.Server.clientID, clientSecret: Constants.Server.clientSecret, baseURLString: Constants.Server.host, accessToken: accessToken, refreshToken: refreshToken)
                    
                    let sessionManager = SessionManager()
                    sessionManager.adapter = oauthHandler
                    sessionManager.retrier = oauthHandler
                    
                    self.sessionManager = sessionManager
                    
                    completion(true, nil)
                    
                } else {
                    
                    completion(false, nil)
                }
            }
        }
    }
    
    func ideas(completion: @escaping (_ ideas: [Idea]?,_ error: Error?) -> Void) -> Void {
        
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        sessionManager?.request(Constants.Server.host + "/api/ideas", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            
            if let error = response.error {
                
                completion(nil, error)
                
            } else if let json = response.result.value {
                
                var ideas: [Idea] = []
                
                if let ideasDict = json as? Array<[String: Any]> {
                    
                    for ideaDict in ideasDict {
                        
                        ideas.append(Parser.ideaFromDict(dict: ideaDict))
                    }
                }
                
                completion(ideas, nil)
            }
        }
    }
    
    func createIdea(with title: String, and ideaDescription: String, completion: @escaping (_ success: Bool,_ error: Error?) -> Void) -> Void {
        
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        let parameters: [String: String] = ["title": title,
                                            "description": ideaDescription]
        
        sessionManager?.request(Constants.Server.host + "/api/ideas", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            
            if let error = response.error {
                
                completion(false, error)
                
            } else {
                
                completion(true, nil)
            }
        }
    }
}
