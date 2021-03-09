//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Roy Park on 3/5/21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSettingsButton))
    }
    
    @objc private func didTapSettingsButton() {
        let settingVC = SettingsViewController()
        settingVC.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.pushViewController(settingVC, animated: true)
    }


}
