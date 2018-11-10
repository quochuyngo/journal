//
//  JError.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 9/9/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import Foundation

enum JError: Error {
    case noInternetConnection
    case userNotAllowUsingLocation
    case normal
    
    func description() -> String {
        switch self {
        case .noInternetConnection:
            return "Please check your internet connection!"
        case .userNotAllowUsingLocation:
            return "Please give us permission use Location"
        default:
            return "Somethings went wrong!"
        }
    }
}

//class JError: Error {
//
//}
