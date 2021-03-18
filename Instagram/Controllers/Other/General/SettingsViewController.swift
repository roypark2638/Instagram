//
//  SettingsViewController.swift
//  Instagram
//
//  Created by Roy Park on 3/5/21.
//

import UIKit
import SafariServices


// no other class can subclass this "final" class
/// View Controller to show user settings
final class SettingsViewController: UIViewController {
    
    private let tableView: UITableView = {
        // grouped will allow us to get the default look of that group table
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var sections = [Section]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // this function will get called after all of the subviews have laid out
    // so we can assign our frames here, that way it will account for things like safearea
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureModels() {
        sections.append(
            Section(title: "Account", option: [
                Option(title: "Edit Profile", handler: { [weak self] in
                    DispatchQueue.main.async {
                        self?.didTapEditProfile()
                    }
                }),
                Option(title: "Invite Friends", handler: { [weak self] in
                    DispatchQueue.main.async {
                        self?.didTapInviteFriends()
                    }
                }),
                Option(title: "Save Original Posts", handler: { [weak self] in
                    DispatchQueue.main.async {
                        self?.didTapSaveOriginalPosts()
                    }
                })
            ]
            ))
        
        sections.append(
            Section(title: "Account", option: [
                Option(title: "Terms of Service", handler: { [weak self] in
                    DispatchQueue.main.async {
                        self?.openURL(type: .terms)
                    }
                }),
                Option(title: "Privacy Policy", handler: { [weak self] in
                    DispatchQueue.main.async {
                        self?.openURL(type: .privacy)
                    }
                }),
                Option(title: "Help / Feedback", handler: { [weak self] in
                    DispatchQueue.main.async {
                        self?.openURL(type: .help)
                    }
                })
                
            ]))
        
        sections.append(Section(title: "", option: [Option(title: "Log Out", handler: { [weak self] in
            DispatchQueue.main.async {
                self?.didTapLogOut()
            }
        })]))
        
    }
    enum SettingsURLType {
        case terms, privacy, help
    }
    
    private func openURL(type: SettingsURLType) {
        let urlString: String
        switch type {
        case .terms: urlString = "https://help.instagram.com/1215086795543252"
        case .privacy: urlString = "https://help.instagram.com/519522125107875"
        case .help: urlString = "https://help.instagram.com/"
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
    }
    
    private func didTapEditProfile() {
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    private func didTapInviteFriends() {
        // show share sheet to invite friends
        
    }
    private func didTapSaveOriginalPosts() {
        
    }

    
    
    private func didTapLogOut() {
        
        let actionSheet = UIAlertController(title: "Log Out",
                                            message: "Are you sure you want to log out?",
                                            preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            AuthManager.shared.logOut() { success in
                DispatchQueue.main.async {
                    // successfully log out
                    if success {
                        let vc = LoginViewController()
                        vc.modalPresentationStyle = .fullScreen
                        // on completion, we should take away the settings and switch back to the main tab
                        // that way, when the user log in again, they're back to the home tab rather than on settings.
                        self.present(vc, animated: true, completion: {
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                        })
                    }
                    // error occurred
                    else {
                        fatalError("Could not log out the user")
                        
                    }
                }
            }
        }))
        
        // make sure it doesn't crash on the iPad
        // if you don't assign this on iPad, the action sheet doesn't know how to present itself
        actionSheet.popoverPresentationController?.sourceView = tableView
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds
        
        present(actionSheet, animated: true, completion: nil)
        
    }
    

}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].option.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = sections[indexPath.section].option[indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // handle cell selection
        let model = sections[indexPath.section].option[indexPath.row]
        model.handler()
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let model = sections[section]
//        return model.title
//    }
    
}




