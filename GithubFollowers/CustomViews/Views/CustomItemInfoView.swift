//
//  CustomItemInfoView.swift
//  GithubFollowers
//
//  Created by Ankit  Mane on 11/18/23.
//

import UIKit

enum itemInfoType {
    case repos, gists, followers, following
}

class CustomItemInfoView: UIView {
    
    let symbolImageView = UIImageView()
    let titleLabel = CustomTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel = CustomTitleLabel(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        
        addSubview(symbolImageView)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func set(infoType: itemInfoType, withCount count: Int){
        switch infoType {
        case .repos:
            symbolImageView.image = UIImage(systemName: SFSymobols.repos)
            titleLabel.text = "Public repos"
        case .gists:
            symbolImageView.image = UIImage(systemName: SFSymobols.gists)
            titleLabel.text = "Public gists"
        case .followers:
            symbolImageView.image = UIImage(systemName: SFSymobols.followers)
            titleLabel.text = "Follower"
        case .following:
            symbolImageView.image = UIImage(systemName: SFSymobols.following)
            titleLabel.text = "Following"
        }
        
        countLabel.text = String(count)
    }
}
