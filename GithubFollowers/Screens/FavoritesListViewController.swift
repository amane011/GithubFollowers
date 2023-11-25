//
//  FavoritesListViewController.swift
//  GithubFollowers
//
//  Created by Ankit  Mane on 10/28/23.
//

import UIKit

class FavoritesListViewController: UIViewController {

    var repos: [Repos] = []
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
            populateRepos()
       }
    
    private func populateRepos() {
        PersistenceManager.retrieveFavRepos { result in
            switch result{
            case .success(let repos):
                self.repos = repos
                self.tableView.reloadData()
            case .failure(let error):
                self.presentCustomAlert(title: "Error", message:error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    private func configure() {
            view.addSubview(tableView)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.register(FavReposTableViewCell.self, forCellReuseIdentifier: "FavCustomCell")
            tableView.dataSource = self
            tableView.delegate = self
            tableView.separatorStyle = .none
            tableView.rowHeight = 180
            
            NSLayoutConstraint.activate([
                       tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                       tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                       tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                       tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
}

extension FavoritesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavCustomCell", for: indexPath) as? FavReposTableViewCell else {
                fatalError("Could not dequeue CustomTableViewCell")
            }
        cell.set(with: repos[indexPath.item])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: repos[indexPath.item].htmlUrl) else {
                    presentCustomAlert(title: "Invalid URl", message: "URl attached to this user is invalid", buttonTitle: "Ok")
                    return
                }
        presentSafariVC(with: url)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        PersistenceManager.updateWith(favorite: repos[indexPath.item], actiontype: .remove) { message in
            self.repos.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}


