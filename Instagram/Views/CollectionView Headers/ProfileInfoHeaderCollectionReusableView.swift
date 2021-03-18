//
//  ProfileInfoHeaderCollectionReusableView.swift
//  Instagram
//
//  Created by Roy Park on 3/17/21.
//

import UIKit

protocol ProfileInfoHeaderCollectionReusableViewDelegate: AnyObject {
    func profileHeaderDidTapPostsButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowersButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapEditProfileButton(_ header: ProfileInfoHeaderCollectionReusableView)
}

final class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    // this is how we are going to get button tap interactions
    public weak var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?
    
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let postsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Posts", for: .normal)
        button.titleLabel?.textColor = .label
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let followersButton: UIButton = {
        let button = UIButton()
        button.setTitle("Followers", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.titleLabel?.textColor = .label
        return button
    }()
    
    private let followingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Following", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.titleLabel?.textColor = .label
        return button
    }()
    
    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit Your Profile", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.titleLabel?.textColor = .label
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.backgroundColor = .secondarySystemBackground
        label.numberOfLines = 1
        label.text = "Roy Park"
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "This is the Bio area"
        label.backgroundColor = .secondarySystemBackground
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addButtonActions()
        backgroundColor = .systemBackground
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureLayouts()
    }
    
    private func addButtonActions() {
        postsButton.addTarget(self,
                              action: #selector(didTapPostsButton),
                              for: .touchUpInside)
        followersButton.addTarget(self,
                              action: #selector(didTapFollowersButton),
                              for: .touchUpInside)
        followingButton.addTarget(self,
                              action: #selector(didTapFollowingButton),
                              for: .touchUpInside)
        editProfileButton.addTarget(self,
                              action: #selector(didTapEditProfileButton),
                              for: .touchUpInside)
    }
    
    private func addSubviews() {
        addSubview(profilePhotoImageView)
        addSubview(postsButton)
        addSubview(followersButton)
        addSubview(followingButton)
        addSubview(editProfileButton)
        addSubview(nameLabel)
        addSubview(bioLabel)
    }
    
    private func configureLayouts() {
        let profilePhotoSize = width / 4
        profilePhotoImageView.frame = CGRect(
            x: 5,
            y: 5,
            width: profilePhotoSize,
            height: profilePhotoSize
        ).integral // integral round up all the number nearest integer
        
        profilePhotoImageView.layer.cornerRadius = profilePhotoSize/2.0
        
        let buttonHeight = profilePhotoSize/2
        let countButtonWidth = (width - 10 - profilePhotoSize) / 3
        
        postsButton.frame = CGRect(
            x: profilePhotoImageView.right,
            y: 5,
            width: countButtonWidth,
            height: buttonHeight
        ).integral // integral round up all the number nearest integer
        
        followersButton.frame = CGRect(
            x: postsButton.right,
            y: 5,
            width: countButtonWidth,
            height: buttonHeight
        ).integral // integral round up all the number nearest integer
        
        followingButton.frame = CGRect(
            x: followersButton.right,
            y: 5,
            width: countButtonWidth,
            height: buttonHeight
        ).integral // integral round up all the number nearest integer
        
        editProfileButton.frame = CGRect(
            x: profilePhotoImageView.right,
            y: 5 + buttonHeight,
            width: countButtonWidth * 3,
            height: buttonHeight
        ).integral // integral round up all the number nearest integer
        
        nameLabel.frame = CGRect(
            x: 5,
            y: 5 + profilePhotoImageView.bottom,
            width: width - 10,
            height: 50
        ).integral // integral round up all the number nearest integer
        
        let bioLabelSize = bioLabel.sizeThatFits(frame.size) // should return based on whatever text we have
        
        bioLabel.frame = CGRect(
            x: 5,
            y: 5 + nameLabel.bottom,
            width: width - 10,
            height: bioLabelSize.height
        ).integral // integral round up all the number nearest integer
    }
    
    // MARK: - Actions
    
    @objc private func didTapPostsButton() {
        // this is how we convey to the VC what happened so the VC can handle it rather than this view class
        delegate?.profileHeaderDidTapPostsButton(self)
    }
    
    @objc private func didTapFollowersButton() {
        delegate?.profileHeaderDidTapFollowersButton(self)
    }
    
    @objc private func didTapFollowingButton() {
        delegate?.profileHeaderDidTapFollowingButton(self)
    }
    
    @objc private func didTapEditProfileButton() {
        delegate?.profileHeaderDidTapEditProfileButton(self)
    }
}
