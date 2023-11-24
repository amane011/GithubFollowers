//
//  PersistenceManager.swift
//  GithubFollowers
//
//  Created by Ankit  Mane on 11/22/23.
//

import Foundation

enum PersistenceManager {
    static private let deafaults = UserDefaults.standard
    
    enum keys {
        static let repos = "repos"
    }
    enum PersistenceActionType {
        case add, remove
    }
    
    static func updateWith(favorite: Repos, actiontype: PersistenceActionType, completed: @escaping (ErrorMessage?) -> Void) {
        retrieveFavRepos { result in
            switch result {
            case .success(var favs):
                
                switch actiontype {
                case .add:
                    guard !favs.contains(favorite) else {
                        completed(.favoriteExixts)
                        return
                    }
                    favs.append(favorite)
                case .remove:
                    favs.removeAll { $0.htmlUrl == favorite.htmlUrl }
                }
                completed(saveFavRepos(favorites: favs))
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retrieveFavRepos(completed: @escaping (Result<[Repos],ErrorMessage>) -> Void) {
        guard let reposData = deafaults.object(forKey: keys.repos) as? Data else {
            completed(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
            let repos = try decoder.decode([Repos].self, from: reposData)
            completed(.success(repos))
        } catch {
            completed(.failure(.unableToGetFavRepos))
        }
    }
    
    static func saveFavRepos(favorites: [Repos]) -> ErrorMessage? {
        do{
            let encoder = JSONEncoder()
            let encodedFav = try encoder.encode(favorites)
            deafaults.setValue(encodedFav, forKey: keys.repos)
            return nil
        } catch {
            return .unableToGetFavRepos
        }
    }
    
    
}
