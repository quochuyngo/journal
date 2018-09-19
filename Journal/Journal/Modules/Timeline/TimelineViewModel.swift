//
//  TimelineViewModel.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 9/9/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//
import RealmSwift

class TimelineViewModel {
    var journalList: [Journal] {
        return sortByDate(DBManager.default.getListJournal())
    }
    var selectedJournal: Journal?
    
    init() {
    }
    
    func sortByDate(_ journals: [Journal]) -> [Journal] {
        return journals.sorted { $0.datetimeEdited! > $1.datetimeEdited! }
    }
    
    func add(_ journal: Journal) {
        DBManager.default.add(journal)
    }
    
    func delete(_ journal: Journal) {
        journal.removeAllImages()
        DBManager.default.delete(journal)
    }
}
