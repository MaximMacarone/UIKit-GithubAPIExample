//
//  SearchViewController.swift
//  UIKitExperiments
//
//  Created by Maxim Makarenkov on 08.02.2025.
//

import UIKit

class SearchViewController: UIViewController {
    
    let followerListViewModelFactory: (String) -> FollowerListViewModel
    
    let logoImageView = UIImageView()
    let usernameTextField = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemIndigo, title: "Find user")
    
    var userNameTextFieldIsEmpty: Bool {
        !(usernameTextField.text?.isEmpty ?? true)
    }
    
    init(followerListViewModelFactory: @escaping (String) -> FollowerListViewModel) {
        self.followerListViewModelFactory = followerListViewModelFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureImageView()
        configureTextField()
        configureActionButton()
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func configureImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        logoImageView.image = UIImage(systemName: "person.fill")
        logoImageView.tintColor = .systemIndigo
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 150),
            logoImageView.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    func configureTextField() {
        usernameTextField.delegate = self
        
        view.addSubview(usernameTextField)
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func configureActionButton() {
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        view.addSubview(callToActionButton)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50),
            callToActionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            callToActionButton.widthAnchor.constraint(equalTo: callToActionButton.titleLabel!.widthAnchor, constant: 64),
        ])
    }
    
    @objc func pushFollowerListVC() {
        guard userNameTextFieldIsEmpty else {
            showSearchErrorAlert()
            return
        }
        let vc = FollowerListViewController(
            viewModel: followerListViewModelFactory(usernameTextField.text ?? "")
        )
        vc.title = usernameTextField.text ?? "Followers"
        
        navigationController?.pushViewController(vc, animated: true)
        self.usernameTextField.text = ""
    }
    
    private func createDismissKeyboardTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func showSearchErrorAlert() {
        presentGFAlertOnMainThread(title: "Provide username", message: "No username was provided. Please type in username in the text field.", buttonTitle: "Try again", buttonAction: {})
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Search"
    }
    
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}
