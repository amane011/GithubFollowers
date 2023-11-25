//
//  String+Ext.swift
//  GithubFollowers
//
//  Created by Ankit  Mane on 11/18/23.
//

import Foundation

extension String {
    func converToDate() -> Date? {
        
        let dateForamtter = DateFormatter()
        dateForamtter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateForamtter.locale = Locale(identifier: "en_US_POSIX")
        dateForamtter.timeZone = .current
        return dateForamtter.date(from: self)
    }
    func converToDisplay() -> String {
        guard let date = self.converToDate() else { return ""}
        return date.convertToMonthYearFormat()
    }

    var isValidEmail: Bool {
        let emailFormat         = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate      = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    
    
    var isValidPassword: Bool {
        //Regex restricts to 8 character minimum, 1 capital letter, 1 lowercase letter, 1 number
        //If you have different requirements a google search for "password requirement regex" will help
        let passwordFormat      = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}"
        let passwordPredicate   = NSPredicate(format: "SELF MATCHES %@", passwordFormat)
        return passwordPredicate.evaluate(with: self)
    }
}
