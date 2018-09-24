//
//  AlertManager.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 9/20/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import UIKit

enum AlertResult {
    case cancel
    case yes
}

struct AlertTitle {
    struct createJournal {
        static let emoji = "Tell us your feeling by select an emoji icon!"
        static let content = "Please write somethings!"
    }
}

enum AlertJournalType {
    case delete
    case create(String)
}

class AlertManager {
    
    static func getAlert(withType type: AlertJournalType, handler: ((AlertResult) -> Void)?) -> UIAlertController {
        switch type {
        case .delete:
            return AlertManager.getDeleteAlert(with: handler!)
        case .create(let title):
            return AlertManager.getCreatPostAlert(with: title)
        }
        
    }
    
    fileprivate static func getDeleteAlert(with handler: @escaping ((AlertResult) -> Void)) -> UIAlertController {
        let alert = UIAlertController(title: "Delete post?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
            _ in
            handler(.yes)
        }))
        return alert
    }
    
    fileprivate static func getCreatPostAlert(with title: String, message: String?  = nil ) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alert
    }
}
