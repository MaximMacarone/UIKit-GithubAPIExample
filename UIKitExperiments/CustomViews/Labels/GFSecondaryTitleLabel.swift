//
//  GFSecondaryTitleLabel.swift
//  UIKitExperiments
//
//  Created by Maxim Makarenkov on 19.02.2025.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {


    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(size: CGFloat) {
        super.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: size, weight: .medium, width: .expanded)
        
        configure()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
    }

}
