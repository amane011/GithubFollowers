//
//  Repos.swift
//  GithubFollowers
//
//  Created by Ankit  Mane on 11/20/23.
//

import Foundation

struct Repos: Codable, Hashable {
    let name: String
    let description: String?
    let updatedAt: String
    let stargazersCount: Int
    let topics: [String]?
    let htmlUrl: String
    let owner: Owner
}
