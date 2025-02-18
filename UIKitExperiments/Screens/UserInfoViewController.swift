//
//  UserInfoViewController.swift
//  UIKitExperiments
//
//  Created by Maxim Makarenkov on 10.02.2025.
//

import UIKit
import Combine

class UserInfoViewController: UIViewController {
    
    // MARK: - properties
    
    let viewModel: UserInfoViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    let headerView = UIView()
    
    
    // MARK: - init
    
    init(viewModel: UserInfoViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureNavBar()
        configureHeaderView()
        configureSubscriptions()
        
        viewModel.vcStatePublisher.send(.viewDidLoad)
    }
    
    // MARK: - subscriptions
    
    private func configureSubscriptions() {
        viewModel.userInfoPublisher
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] completion in
                switch completion {
                    
                case .finished:
                    print("viewModel.userInfoPublisher finished")
                case .failure(let error):
                    self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK") { [unowned self] in
                        self.dismissVC()
                    }
                }
            } receiveValue: { [weak self] user in
                guard let self = self else { return }
                self.add(childVC: UserInfoHeaderViewController(user: user), to: headerView)
            }
            .store(in: &subscriptions)

    }
    
    // MARK: - UI configuration
    
    private func configureHeaderView() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func add(childVC: UIViewController, to container: UIView) {
        addChild(childVC)
        container.addSubview(childVC.view)
        childVC.view.frame = container.bounds
        childVC.didMove(toParent: self)
    }
    
    private func configureNavBar() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }

}
