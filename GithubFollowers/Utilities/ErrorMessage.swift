//
//  ErrorMessage.swift
//  GithubFollowers
//
//  Created by Ankit  Mane on 11/13/23.
//

import Foundation

enum ErrorMessage: String {
    case invalidUsername = "This username created an invalid request. Please try again"
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again"
    case invalidData = "Data received was invalid. Please try again"
}
