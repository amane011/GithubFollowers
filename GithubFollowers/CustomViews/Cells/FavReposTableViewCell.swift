//
//  FavReposTableViewCell.swift
//  GithubFollowers
//
//  Created by Ankit  Mane on 11/23/23.
//

import UIKit

class FavReposTableViewCell: UITableViewCell {

    
    let titleLabel = CustomTitleLabel(textAlignment: .left, fontSize: 18)
    let descriptionLabel = CustomSecondaryTitleLabel(fontSize: 14)
    let dateLabel = CustomBodyLabel(textAlignment: .left)
    let containerView = UIView()
    let starImageView = UIImageView()
    let starText = CustomBodyLabel(textAlignment: .center)
    let ownerName = CustomTitleLabel(textAlignment: .left, fontSize: 20)
    let ownerAvatar = CustomImageView(frame: .zero)
    
    var deleagte: RepoListDelegate?
    var currentRepo: Repos! {
        didSet {
            configure()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConatinerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func set(with repo: Repos){
        currentRepo = repo
        configure()
       }
    
    private func setupConatinerView() {
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(ownerName)
        containerView.addSubview(ownerAvatar)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(dateLabel)
        containerView.addSubview(starImageView)
        containerView.addSubview(starText)

        let cellPadding: CGFloat = 10
        containerView.layer.cornerRadius = 18
        containerView.backgroundColor = .secondarySystemBackground

        titleLabel.textColor = .systemBlue
        descriptionLabel.numberOfLines = 2
        dateLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        starText.font = UIFont.systemFont(ofSize: 12, weight: .light)
        starText.numberOfLines = 1
        starImageView.translatesAutoresizingMaskIntoConstraints = false
       
        NSLayoutConstraint.activate([
            // Constraints for containerView
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: cellPadding),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: cellPadding),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -cellPadding),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -cellPadding),

            ownerAvatar.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            ownerAvatar.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            ownerAvatar.heightAnchor.constraint(equalToConstant: 25),
            ownerAvatar.widthAnchor.constraint(equalToConstant: 25),
            
            ownerName.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            ownerName.leadingAnchor.constraint(equalTo: ownerAvatar.trailingAnchor, constant: 10),
            ownerName.heightAnchor.constraint(equalToConstant: 28),
            ownerName.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            
            titleLabel.topAnchor.constraint(equalTo: ownerAvatar.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 24),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 40),

            dateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),
            
            starText.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            starText.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            starText.heightAnchor.constraint(equalToConstant: 20),
            
            starImageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            starImageView.trailingAnchor.constraint(equalTo: starText.leadingAnchor, constant: -5),
            starImageView.widthAnchor.constraint(equalToConstant:20),
            starImageView.heightAnchor.constraint(equalToConstant: 20),
        ])
    }

    private func configure() {
        titleLabel.text = currentRepo.name
        descriptionLabel.text = currentRepo.description
        dateLabel.text = "Updated on \(currentRepo.updatedAt.converToDisplay())"
        starImageView.image = UIImage(systemName: "star.fill")
        starText.text = String(currentRepo.stargazersCount)
        ownerName.text = currentRepo.owner.login
        ownerAvatar.downloadImage(from: currentRepo.owner.avatarUrl)
        
    }
    
   
}
