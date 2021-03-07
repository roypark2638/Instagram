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
    
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        /*
         - Check if username is available
         - Check if email is available
         */
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { (canCreate) in
            if canCreate {
                /*
                - Create account in Firebase
                - Insert account to database
                */
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    guard result != nil, error == nil else {
                        // Firebase auth coult not create an account
                        completion(false)
                        return
                    }
                    
                    // Successfully created an account, insert into database
                    DatabaseManager.shared.insertNewUser(with: email, username: username) { (inserted) in
                        // success to insert into database
                        if inserted {
                            completion(true)
                            return
                        }
                        // failed to insert into database
                        else {
                            completion(false)
                            return
                        }
                    }
                }
            }
            else {
                // either username or email does not exist
                completion(false)
            }
        }
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
