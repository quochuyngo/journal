//
//  DBManager.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 9/10/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import RealmSwift

protocol BaseDBManager {
}
class DBManager: BaseDBManager {
    static var `default` = DBManager()
    var realm = try! Realm(configuration: DBManager.configDB())
    
    func getListJournal() -> [Journal] {
        let journalList = realm.objects(Journal.self)
        return Array(journalList)
    }
    
    func add(_ journal: Journal) {
        try! realm.write {
            realm.add(journal)
        }
    }
    
    func delete(_ journal: Journal) {
        try! realm.write {
            realm.delete(journal)
        }
    }
    
    func update(_ journal: Journal) {
        try! realm.write {
            //realm.create(Journal.self, value: journal, update: true)
            realm.add(journal, update: true)
            try! realm.commitWrite()
        }
    }
    
    static func configDB() -> Realm.Configuration {
        return Realm.Configuration (
            schemaVersion: 5,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 5) {
                    //migrate DB
                }
        })
    }
    
    class func convertArrayToList<T>(with array:[T]) -> List<T> {
        let result = List<T>()
        array.forEach { result.append($0)}
        return result
    }
}
