//
//  Place.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 9/2/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//
import RealmSwift

class Place: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var address: String = ""
    
    convenience init(title: String, address: String) {
        self.init()
        self.title = title
        self.address = address
    }
}
