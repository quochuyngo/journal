//
//  Array+Ext.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 9/18/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import RealmSwift
extension Array {
    func toList<T>() -> List<T> {
        let result = List<T>()
        self.forEach { result.append($0 as! T)}
        return result
    }
}

extension List {
    func toArray<T>() -> Array<T> {
        return Array(self) as! [T]
    }
}
