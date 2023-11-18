//
//  UIViewController+ext.swift
//  GithubFollowers
//
//  Created by Ankit  Mane on 11/10/23.
//

import UIKit

fileprivate var containerView: UIView!

extension UIViewController {
    
    func presentCustomAlert(title: String, message: String, buttonTitle: String){
        DispatchQueue.main.async {
            let alertVc = CustomAlertViewController(alertTitle: title, message: message, buttonTitle: buttonTitle)
            alertVc.modalPresentationStyle = .overFullScreen
            alertVc.modalTransitionStyle = .crossDissolve
            self.present(alertVc, animated: true)
        }
    }
    
    func showLoadingView(){
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.backgroundColor  = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.8) { containerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
        
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    func showEmptyStateView(message: String, view: UIView ) {
        let emptyStateView = CustomEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}
