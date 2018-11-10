//
//  EmojiItem.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 5/13/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//
import RealmSwift

enum EmojiType: String {
    case happy = "Happy"
    case bad = "Bad"
    case cool = "Cool"
    case excited = "Excited"
    case angry = "Angry"
    case awful = "Awful"
}

class EmojiItem: Object, AddingItemProtocol {
    var type: EmojiType {
        get {
            return EmojiType(rawValue: emojiType) ?? .happy
        }
        set {
            emojiType = newValue.rawValue
        }
    }
    var isSelected: Bool = false
    @objc dynamic var emojiType: String = ""
    
    var icon: String {
        switch type {
        case .happy:
            return !isSelected ? "ic_happy" : "ic_happy_selected"
        case .bad:
            return !isSelected ? "ic_sad" : "ic_sad_selected"
        case .cool:
            return !isSelected ? "ic_cool" : "ic_cool_selected"
        case .excited:
            return !isSelected ? "ic_excited" : "ic_excited_selected"
        case .angry:
            return !isSelected ? "ic_angry" : "ic_angry_selected"
        case .awful:
            return !isSelected ? "ic_awful" : "ic_awful_selected"
        }
    }
    
    convenience init(_ emojiType: EmojiType, isSelected: Bool = false) {
        self.init()
        self.type = emojiType
        self.isSelected = isSelected
    }
}