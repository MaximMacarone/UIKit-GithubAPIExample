//
//  GFAlertViewController.swift
//  UIKitExperiments
//
//  Created by Maxim Makarenkov on 08.02.2025.
//

import UIKit

class GFAlertViewController: UIViewController {
    
    let containerView = UIView()
    let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 18)
    let bodyLabel = GFBodyLabel(textAlignment: .center)
    let actionButton = GFButton(backgroundColor: .systemIndigo, title: "Try again")
    let containerPadding: CGFloat = 24
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    var completion: (() -> Void)?
    
    init(title:String, message: String, buttonTitle: String, completion: @escaping () -> Void) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
        self.completion = completion
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureBodyLabel()
    }
    
    private func configure() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }
    
    private func configureContainerView() {
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.systemGray6.cgColor
        containerView.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 250),
            containerView.widthAnchor.constraint(equalToConstant: 300)
        ])
        
    }
    
    private func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        
        titleLabel.text = alertTitle ?? "There was an error"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: containerPadding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: containerPadding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -containerPadding),
            titleLabel.heightAnchor.constraint(equalToConstant: 32),
        ])
    }
    
    private func configureBodyLabel() {
        containerView.addSubview(bodyLabel)
        
        bodyLabel.text = message ?? "Something went wrong. Please try again later."
        bodyLabel.numberOfLines = 5
        
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: containerPadding),
            bodyLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -containerPadding),
            bodyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: containerPadding),
            bodyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -containerPadding),
            
        ])
    }
    
    private func configureActionButton() {
        containerView.addSubview(actionButton)
        
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -containerPadding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: containerPadding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -containerPadding),
            actionButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            (self.completion ?? {})()
        }
    }
    

}
