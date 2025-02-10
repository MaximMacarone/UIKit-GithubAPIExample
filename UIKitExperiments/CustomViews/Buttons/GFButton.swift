//
//  GFButton.swift
//  UIKitExperiments
//
//  Created by Maxim Makarenkov on 08.02.2025.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        addTapEffect()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor bg: UIColor, title: String) {
        super.init(frame: .zero)
        
        backgroundColor = bg
        setTitle(title, for: .normal)
        
        configure()
    }
    
    private func configure() {
        layer.cornerRadius      = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font        = UIFont.systemFont(ofSize: 16, weight: .semibold, width: .expanded)
        
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func addTapEffect() {
        addTarget(self, action: #selector(animateDown), for: .touchDown)
        addTarget(self, action: #selector(animateUp), for: [.touchUpInside, .touchUpOutside])
    }
    
    @objc private func animateDown() {
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            self.alpha = 0.1
        }
    }
    
    @objc private func animateUp() {
        UIView.animate(withDuration: 0.1) {
            self.transform = .identity
            self.alpha = 1.0
        }
    }
    
}
