//
//  RepoItemVC.swift
//  GithubFollowers
//
//  Created by Ankit  Mane on 11/18/23.
//

import UIKit

class RepoItemVC: CustomItemInfoVC {
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems(){
        itemInfoViewOne.set(infoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(infoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Get Repositories")
    }
    
    override func actionButtonPressed() {
        delgate.didTapGitHubProfile(for: user)
    }
    
}
