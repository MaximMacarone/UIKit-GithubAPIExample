//
//  GFEmptyStateView.swift
//  UIKitExperiments
//
//  Created by Maxim Makarenkov on 09.02.2025.
//

import UIKit

class GFEmptyStateView: UIView {
    
    let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 24)
    let logoImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String) {
        super.init(frame: .zero)
        
        titleLabel.text = message
        configure()
    }
    
    private func configure() {
        addSubview(titleLabel)
        addSubview(logoImageView)
        
        logoImageView.image = UIImage(systemName: "person.2.slash.fill")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.numberOfLines = 5
        titleLabel.textColor = .secondaryLabel
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40),
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
        ])
    }

}
