//
//  Date+Ext.swift
//  GithubFollowers
//
//  Created by Ankit  Mane on 11/18/23.
//

import UIKit
extension Date {
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
