//
//  TimelineViewModel.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 9/9/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//
import RealmSwift

class TimelineViewModel {
    let databaseManager: DBManager
    var journalList: [Journal] {
        return sortByDate(databaseManager.getListJournal())
    }
    
    var selectedJournal: Journal?
    var selectedIndex: Int!
    
    
    init(databaseManager: DBManager) {
        self.databaseManager = databaseManager
    }
    
    private func sortByDate(_ journals: [Journal]) -> [Journal] {
        return journals.sorted { $0.datetimeEdited! > $1.datetimeEdited! }
    }
    
    func delete(_ journal: Journal) {
        journal.removeAllImages()
        DBManager.default.delete(journal)
    }
}
