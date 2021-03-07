//
//  RegistrationViewController.swift
//  Instagram
//
//  Created by Roy Park on 3/5/21.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    struct Constants {
        static let cornorRadius = CGFloat(8.0)
    }

    // Create anomyous closures
    private let usernameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.backgroundColor = .secondarySystemBackground
        field.layer.cornerRadius = Constants.cornorRadius
        field.layer.masksToBounds = true
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email Address"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.backgroundColor = .secondarySystemBackground
        field.layer.cornerRadius = Constants.cornorRadius
        field.layer.masksToBounds = true
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.isSecureTextEntry = true
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.backgroundColor = .secondarySystemBackground
        field.layer.cornerRadius = Constants.cornorRadius
        field.layer.masksToBounds = true
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        
        return field
    }()
    
    private let signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornorRadius
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    private let termsOfService: UIButton = {
        let button = UIButton()
        button.setTitle("Terms Of Service", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let privacyPolicy: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        addSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // add frame of the UI
        usernameField.frame = CGRect(
            x: 20,
            y: view.safeAreaInsets.top + 100,
            width: view.width - 50,
            height: 52.0
        )
        
        emailField.frame = CGRect(
            x: 20,
            y: usernameField.bottom + 10,
            width: view.width - 50,
            height: 52.0
        )
        
        passwordField.frame = CGRect(
            x: 20,
            y: emailField.bottom + 10,
            width: view.width - 50,
            height: 52.0
        )
        
        signupButton.frame = CGRect(
            x: 20,
            y: passwordField.bottom + 10,
            width: view.width - 50,
            height: 52.0
        )
        
        termsOfService.frame = CGRect(
            x: 10,
            y: view.height - view.safeAreaInsets.bottom - 100,
            width: view.width - 20,
            height: 50.0
        )
        
        privacyPolicy.frame = CGRect(
            x: 10,
            y: view.height - view.safeAreaInsets.bottom - 50,
            width: view.width - 20,
            height: 50.0
        )
    }
    
    private func addSubviews() {
        view.addSubview(usernameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signupButton)
        view.addSubview(termsOfService)
        view.addSubview(privacyPolicy)
    }
    
    @objc private func didTapRegisterButton() {
        // dismiss the keyboard
        usernameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        // Validate if user enter LEAST requirment for creating a new account.
        // More validation will be conducted from AuthManager Method "registerNewUser"
        guard let username = usernameField.text, !username.isEmpty,
              let emailaddress = emailField.text, !emailaddress.isEmpty,
              let password = passwordField.text, password.count >= 8 else {
            return
            
        }
        
        AuthManager.shared.registerNewUser(username: username, email: emailaddress, password: password) { (registered) in
            // we are going to update our UI so use DispatchQueue
            DispatchQueue.main.async {
                // success to register an account
                if registered {
                    return
                }
                // failed to register an account
                else {
                    return
                }
            }
            
        }
    }

}


//MARK: Registration Extension -> UITextfieldDelegate
extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // when user hit enter, it will excute the following code
        if textField == usernameField {
            emailField.becomeFirstResponder()
        }
        else if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            didTapRegisterButton()
        }
        return true
    }
}
