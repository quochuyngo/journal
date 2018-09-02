//
//  EmojiItem.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 5/13/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

enum EmojiType: String {
    case happy = "Happy"
    case bad = "Bad"
    case cool = "Cool"
    case excited = "Excited"
    case angry = "Angry"
    case awful = "Awful"
}

struct EmojiItem {
    var type: EmojiType
    var isSelected: Bool
    
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
    
    init(_ emojiType: EmojiType, isSelected: Bool = false) {
        self.type = emojiType
        self.isSelected = isSelected
    }
}
