//
//  UserInfoViewController.swift
//  GithubFollowers
//
//  Created by Ankit  Mane on 11/17/23.
//

import UIKit

protocol UserInfoVCDelgate: AnyObject {
    func didTapGitHubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}

class UserInfoViewController: UIViewController {
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = CustomBodyLabel(textAlignment: .center)
    
    var itemViews: [UIView] = []
    
    weak var delegate: FollowerListVCDelegate!
    var userName: String!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        layoutUI()
        getUserInfo()
    }
    
    func configureVC() {
        view.backgroundColor = .systemBackground
//        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
//        navigationItem.rightBarButtonItem = doneButton
    }
    
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: userName) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.configureUIElements(with: user)
                }
            case .failure(let error):
                self.presentCustomAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                
            }
            
        }
    }
    func configureUIElements(with user: User ) {
        let repoItemVC = RepoItemVC(user: user)
        repoItemVC.delgate = self
        
        let followerItemVC = FollowerItemVC(user: user)
        followerItemVC.delgate = self

        self.add(childVC: UserInfoHeaderViewController(user: user), to: self.headerView)
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        self.dateLabel.text = " GitHub since \(user.createdAt.converToDisplay())"
    }
    func layoutUI(){
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
        
       
        
        NSLayoutConstraint.activate([
                   headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                   headerView.heightAnchor.constraint(equalToConstant: 210),
                   
                   itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
                   itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
                   
                   itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
                   itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
                   
                   dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
                   dateLabel.heightAnchor.constraint(equalToConstant: 18)
               ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }

    @objc func dismissVC(){
        dismiss(animated: true)
    }

}

extension UserInfoViewController: UserInfoVCDelgate {
    func didTapGitHubProfile(for user: User) {
//        guard let url = URL(string: user.htmlUrl) else {
//            presentCustomAlert(title: "Invalid URl", message: "URl attached to this user is invalid", buttonTitle: "Ok")
//            return
//        }
//        presentSafariVC(with: url)
        let repoListVc = RepoListsViewController()
        repoListVc.userName = userName
        navigationController?.pushViewController(repoListVc, animated: true)
        
    }
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentCustomAlert(title: "No followers", message: "This user has no followers", buttonTitle: "OK")
            return
        }
//        delegate.didRequestFollowers(for: user.login)
        
        let followeListVC = FollowersListViewController()
        followeListVC.userName = userName
        followeListVC.title = userName
        navigationController?.pushViewController(followeListVC, animated: true)
//        dismissVC()
    }
    
    
    
}
