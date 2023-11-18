//
//  UserInfoViewController.swift
//  GithubFollowers
//
//  Created by Ankit  Mane on 11/17/23.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    var userName: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        
        NetworkManager.shared.getUserInfo(for: userName) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                print(user)
                
            case .failure(let error):
                self.presentCustomAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                
            }
            
        }
    }
    

    @objc func dismissVC(){
        dismiss(animated: true)
    }

}
