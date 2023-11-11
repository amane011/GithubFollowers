//
//  UIViewController+ext.swift
//  GithubFollowers
//
//  Created by Ankit  Mane on 11/10/23.
//

import UIKit

extension UIViewController {
    func presentCustomAlert(title: String, message: String, buttonTitle: String){
        DispatchQueue.main.async {
            let alertVc = CustomAlertViewController(alertTitle: title, message: message, buttonTitle: buttonTitle)
            alertVc.modalPresentationStyle = .overFullScreen
            alertVc.modalTransitionStyle = .crossDissolve
            self.present(alertVc, animated: true)
        }
    }
}
