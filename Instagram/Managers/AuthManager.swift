//
//  AuthManager.swift
//  Instagram
//
//  Created by Roy Park on 3/6/21.
//

import FirebaseAuth

public class AuthManager {
    static let shared = AuthManager()
    
    // MARK: - Public
    
    public func registerNewUser(username: String, email: String, password: String) {
        
    }
    
    // the completion return Bool value. The bool represents if the user successfully signin or not
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
        // the reason why using @escaping is we use completion isside of another closure and as teh re
        if let email = email {
            // email log in
            Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
                // user successfully logged in
                guard authDataResult != nil, error == nil else {
                    completion(false)
                    return
                }
                
                completion(true)
            }
        }
        else if let username = username {
            // username log in
            Auth.auth().signIn(withEmail: username, password: password) { (authDataResult, error) in
                // user successfully logged in
                guard authDataResult != nil, error == nil else {
                    completion(false)
                    return
                }
                
                completion(true)
            }
        }
    }
}
