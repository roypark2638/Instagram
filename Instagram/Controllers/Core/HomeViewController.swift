//
//  ViewController.swift
//  Instagram
//
//  Created by Roy Park on 3/5/21.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // check auth status
        handleNotAuthenticated()
    }

    private func handleNotAuthenticated() {
        if Auth.auth().currentUser == nil {
            // show log in page
            let loginVC = LoginViewController()
            // set the loginVC fullScreen so that user can't swipe the page away
            loginVC.modalPresentationStyle = .fullScreen
            
            present(loginVC, animated: false)
        }
        else {
            
        }
        
    }

}

