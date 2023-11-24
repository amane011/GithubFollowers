//
//  FollowerItemVC.swift
//  GithubFollowers
//
//  Created by Ankit  Mane on 11/18/23.
//

import UIKit

class FollowerItemVC: CustomItemInfoVC {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems(){
        itemInfoViewOne.set(infoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(infoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonPressed() {
        delgate.didTapGetFollowers(for: user)
    }
}
