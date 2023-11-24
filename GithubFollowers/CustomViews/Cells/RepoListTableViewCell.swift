//
//  RepoListTableViewCell.swift
//  GithubFollowers
//
//  Created by Ankit  Mane on 11/20/23.
//

import UIKit



class RepoListTableViewCell: UITableViewCell {
    
    let titleLabel = CustomTitleLabel(textAlignment: .left, fontSize: 18)
    let descriptionLabel = CustomSecondaryTitleLabel(fontSize: 14)
    let dateLabel = CustomBodyLabel(textAlignment: .left)
    let containerView = UIView()
    let starImageView = UIImageView()
    let starText = CustomBodyLabel(textAlignment: .center)
    let heartButton = UIImageView()
    
    var deleagte: RepoListDelegate?
    var hasFav = false
    var favRepos: [Repos] = []
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
    func set(with repo: Repos, favRepos: [Repos]){
        currentRepo = repo
        self.favRepos = favRepos
        configure()
       }
    
    private func setupConatinerView() {
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false

        // Add subviews to containerView instead of contentView
        containerView.addSubview(heartButton)
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
        heartButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Constraints for containerView
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: cellPadding),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: cellPadding),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -cellPadding),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -cellPadding),

            // Constraints for titleLabel, descriptionLabel, dateLabel within containerView
            heartButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            heartButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            heartButton.heightAnchor.constraint(equalToConstant: 20),
            heartButton.widthAnchor.constraint(equalToConstant: 20),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: heartButton.leadingAnchor, constant: 10),
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
        if favRepos.contains(currentRepo) {
            hasFav = true
            heartButton.image = UIImage(systemName: "heart.fill")
        } else {
            hasFav = false
            heartButton.image = UIImage(systemName: "heart")
        }
        
        starText.text = String(currentRepo.stargazersCount)
        heartButton.isUserInteractionEnabled = true
        let tapGesture =  UITapGestureRecognizer(target: self, action: #selector(heartPressed))
        heartButton.addGestureRecognizer(tapGesture)
    }
    
    @objc func heartPressed() {
        hasFav.toggle()
        if hasFav {
            heartButton.image = UIImage(systemName: "heart.fill")
            deleagte?.addToFav(for: currentRepo, action: .add)
        } else {
            heartButton.image = UIImage(systemName: "heart")
            deleagte?.addToFav(for: currentRepo, action: .remove)
        }
        
    }
}
