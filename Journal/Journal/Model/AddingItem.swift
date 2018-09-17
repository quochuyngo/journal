//
//  AddingItem.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 5/12/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//


enum ItemType {
    case location
    case emotion
    case tag
    case photo
}

struct AddingItem {
    var itemType: ItemType
    var isSelected: Bool
    
    var icon: String {
        get {
            switch itemType {
            case .location:
                return isSelected ? "ic_location_selected" : "ic_location"
            case .emotion:
                return isSelected ? "ic_happiness_selected" : "ic_happiness"
            case .tag:
                return isSelected ? "ic_tag_selected" : "ic_tag"
            case .photo:
                return isSelected ? "ic_camera_selected" : "ic_camera"
            }
        }
    }
    
    init(_ itemType: ItemType, isSelected: Bool = false) {
        self.itemType = itemType
        self.isSelected = isSelected
    }
    
    mutating func set(itemSelected: Bool) {
        self.isSelected = itemSelected
    }
}
