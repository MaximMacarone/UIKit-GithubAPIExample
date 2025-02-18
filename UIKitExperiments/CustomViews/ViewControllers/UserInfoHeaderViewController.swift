//
//  UserInfoHeaderViewController.swift
//  UIKitExperiments
//
//  Created by Maxim Makarenkov on 19.02.2025.
//

import UIKit
import Combine

class UserInfoHeaderViewController: UIViewController {
    
    // MARK: - dependencies
    
    // MARK: - properties
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel = GFSecondaryTitleLabel(size: 18)
    let locationImageView = UIImageView()
    let locationLabel = GFSecondaryTitleLabel(size: 12)
    let bioLabel = GFBodyLabel(textAlignment: .left)
    
    let user: User
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - init
    
    init(user: User) {
        self.user = user
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layoutSubviews()
        configure()
        configureUserSubscription()
    }
    
    // MARK: - subscriptions
    
    private func configureUserSubscription() {
        self.avatarImageView.downloadImage(from: user.avatarUrl)
        self.usernameLabel.text = user.login
        self.nameLabel.text = user.name ?? ""
        self.locationLabel.text = user.location ?? "No location provided"
        self.bioLabel.text = user.bio ?? "No bio available"
    }
    
    // MARK: - UI configuration
    
    private func layoutSubviews() {
        view.addSubview(avatarImageView)
        view.addSubview(usernameLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationImageView)
        view.addSubview(locationLabel)
        view.addSubview(bioLabel)
    }
    
    private func configure() {
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        
        bioLabel.numberOfLines = 3
        
        locationImageView.image = UIImage(systemName: SFSymbols.location)
        locationImageView.tintColor = .secondaryLabel
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 18),
            locationImageView.heightAnchor.constraint(equalToConstant: 18),
            
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 8),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
        ])
    }
}
