//
//  UIViewController+Ext.swift
//  UIKitExperiments
//
//  Created by Maxim Makarenkov on 08.02.2025.
//

import UIKit

fileprivate var containerView: UIView!

extension UIViewController {
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String, buttonAction: @escaping () -> Void) {
        DispatchQueue.main.async {
            let alertVC = GFAlertViewController(title: title, message: message, buttonTitle: buttonTitle, completion: buttonAction)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func showFullScreenLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.6
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
        activityIndicator.color = .systemIndigo
        activityIndicator.startAnimating()
    }
    
    func dismissFullScreenLoadingView() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.25) {
                containerView.removeFromSuperview()
                containerView = nil
            }
        }
    }
    
    func showNavBarLoadingIndicator(animated: Bool) {
        let activityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicatorView.startAnimating()
        
        UIView.animate(withDuration: animated ? 0.25 : 0) {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityIndicatorView)
        }
    }
    
    func dismissNavBarLoadingIndicator(animated: Bool) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: animated ? 0.25 : 0) {
                self.navigationItem.rightBarButtonItem = nil
            }
            
        }
    }
    
    func showEmptyStateView(in view: UIView, message: String) {
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}

