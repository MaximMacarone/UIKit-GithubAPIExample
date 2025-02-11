//
//  UserInfoViewController.swift
//  UIKitExperiments
//
//  Created by Maxim Makarenkov on 10.02.2025.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    var username: String!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        configureNavBar()
    }
    
    func configureNavBar() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }

}
