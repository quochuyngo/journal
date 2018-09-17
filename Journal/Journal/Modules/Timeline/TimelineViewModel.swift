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
        return DBManager.default.getListJournal()
    }
    var selectedJournal: Journal?
    
    init() {
    }
    
    func add(_ journal: Journal) {
        DBManager.default.add(journal)
    }
    
    func delete(_ journal: Journal) {
        journal.removeAllImages()
        DBManager.default.delete(journal)
    }
//    
//    func edit(_ journal: Journal) {
//        DBManager.default.
//    }
//    
//    func edit(with emoji: EmojiItem?, place: Place?, image) {
//        
//    }
}
