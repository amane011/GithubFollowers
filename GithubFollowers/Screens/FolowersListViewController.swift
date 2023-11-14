//
//  FolowersListViewController.swift
//  GithubFollowers
//
//  Created by Ankit  Mane on 11/9/23.
//

import UIKit

class FolowersListViewController: UIViewController {
    
    var userName : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowers(for: userName, page: 1) { followers, error in
            guard let followers = followers else {
                self.presentCustomAlert(title: "Something bad happened", message: error!, buttonTitle: "Ok")
                return
            }
            print(followers)
        }
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)

    }

}
