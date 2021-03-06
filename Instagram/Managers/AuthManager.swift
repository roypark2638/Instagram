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
    
    /// Attempt to register a new user from firebase database
    /// - parameters
    ///     username: String representing username
    ///     email: String representing email
    ///     password: String representing password
    ///     completion: Async callback if firebase database successfully create and insert account into the database
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
    
    /// Attempt to log in firebase user
    /// - parameters
    ///     username: optional String representing username
    ///     email: optional String representing email
    ///     password: String representing password
    ///     completion: Async callback for result if firebase successfully log in the user
    // the completion return Bool value. The bool represents if the user successfully sign in or not
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
        // the reason why using @escaping is we use completion inside of another closure
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
    
    /// Attemp to log out firebase user
    /// - parameters
    ///     completion: Async callback for result if firebase successfully log out the user
    public func logOut(completion: (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        }
        catch {
            print(error)
            completion(false)
            return
        }
    }
    
}
