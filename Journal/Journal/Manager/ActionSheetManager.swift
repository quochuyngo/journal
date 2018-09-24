//
//  AlertManager.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 9/9/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import UIKit

enum MoreOptions {
    case edit(Journal)
    case delete(Journal)
    case shareFaceBook(Journal)
}

enum ActionSheetType {
    case more
    case delete
}

class ActionSheetManager {
    
    static var actionDidSelect: ((_ action: MoreOptions) -> Void)?

    class func getActionSheet(withType type: ActionSheetType, _ journal: Journal) -> UIAlertController {
        switch type {
        case .more:
            return ActionSheetManager.getMoreActionSheet(journal)
        case .delete:
            return ActionSheetManager.getDeleteActionSheet(journal)
        }
    }
    
    fileprivate class func getMoreActionSheet(_ journal: Journal) -> UIAlertController {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title:"Cancel", style:.cancel))
        
//        actionSheet.addAction(UIAlertAction(title: "Share on Facebook", style: .default, handler: {
//            _ in
//            self.actionDidSelect?(.shareFaceBook(journal))
//            
//        }))
        
        let editAction = UIAlertAction(title: "Edit", style: .default, handler: {
            _ in
            self.actionDidSelect?(.edit(journal))
        })
        actionSheet.addAction(editAction)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .default, handler: {
            _ in
            self.actionDidSelect?(.delete(journal))
        })
        deleteAction.setValue(UIColor.red, forKey: "titleTextColor")
        actionSheet.addAction(deleteAction)
        
        return actionSheet
    }
    
    fileprivate class func getDeleteActionSheet(_ journal: Journal) -> UIAlertController {
         let actionSheet = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        return actionSheet
    }
}
