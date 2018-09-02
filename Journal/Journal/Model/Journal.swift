//
//  Journal.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 5/10/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import Foundation
import UIKit
class Journal {
    var id: String = UUID().uuidString
    var content: String = ""
    var location: String = ""
    var emotion: EmojiItem = EmojiItem(.happy)
    var tags: [String] = []
    var photos: [String] = []
    var images: [UIImage]?
    var datetime: Date = Date()
    
    init(content: String, location: String, emotion: EmojiItem, photos: [String]?, images: [UIImage]?) {
        self.content = content
        self.location = location
        self.emotion = emotion
        if let photos = photos {
            self.photos = photos
        }
        if let images = images {
            self.images = images
        }
    }
}
