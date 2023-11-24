//
//  RepoListsViewController.swift
//  GithubFollowers
//
//  Created by Ankit  Mane on 11/20/23.
//

import UIKit

protocol RepoListDelegate: AnyObject {
    func addToFav(for repo: Repos, action: PersistenceManager.PersistenceActionType)
    func hasFavs(for repo: Repos)-> Bool
}

class RepoListsViewController: UIViewController {
    
    var userName: String!
    var repos: [Repos] = []
    let tableView = UITableView()
    var favRepos: [Repos] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRepos()
        configTableView()
        getFavRepos()
    }
    
    func printUsers(){
        for repo in repos {
            print(repo.name)
        }
    }
    func configTableView(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RepoListTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 140
        
        NSLayoutConstraint.activate([
                   tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                   tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                   tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                   tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
               ])
    }
    
    func getRepos() {
        showLoadingView()
        NetworkManager.shared.getRepos(for: userName) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let repos):
                DispatchQueue.main.async {
                    self.repos.append(contentsOf: repos)
                    self.repos.sort { (repo1, repo2) -> Bool in
                        let formatter = ISO8601DateFormatter()
                        
                        // Convert the updatedAt strings to Date objects
                        let date1 = formatter.date(from: repo1.updatedAt) ?? Date.distantPast
                        let date2 = formatter.date(from: repo2.updatedAt) ?? Date.distantPast

                        // Compare dates, the later date should come first
                        return date1 > date2
                    }

                    self.tableView.reloadData()
                }
            case .failure(let error):
                self.presentCustomAlert(title: "Something bad happened", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    func getFavRepos(){
        PersistenceManager.retrieveFavRepos { result in
            switch result {
            case .success(let repos):
                self.favRepos.append(contentsOf: repos)
                break
            case .failure(_):
                break
            }
        }
    }
}



extension RepoListsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? RepoListTableViewCell else {
                fatalError("Could not dequeue CustomTableViewCell")
            }
        cell.set(with: repos[indexPath.item], favRepos: favRepos)
        cell.deleagte = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: repos[indexPath.item].htmlUrl) else {
                    presentCustomAlert(title: "Invalid URl", message: "URl attached to this user is invalid", buttonTitle: "Ok")
                    return
                }
        presentSafariVC(with: url)
    }
}

extension RepoListsViewController: RepoListDelegate{
    func hasFavs(for repo: Repos) -> Bool {
        return favRepos.contains(repo)
    }
    
    func addToFav(for repo: Repos, action actionType: PersistenceManager.PersistenceActionType) {
        if actionType == .add {
            favRepos.append(repo)
        }
        
        if actionType == .remove {
            if let index = favRepos.firstIndex(of: repo) {
                favRepos.remove(at: index)
            }
        }
            
        PersistenceManager.updateWith(favorite: repo, actiontype: actionType) { error in
            guard let error = error else { return }
            self.presentCustomAlert(title: "Error", message: error.rawValue, buttonTitle: "Ok")
        }
    }
    
    
}
