//
//  Journal.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 5/10/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import RealmSwift

class Journal: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var content: String = ""
    @objc dynamic var location: Place? = Place()
    @objc dynamic var emotion: EmojiItem? = EmojiItem(.happy)
    @objc dynamic var datetime: Date = Date()
    let imagesURL = List<String>()
    let photos = List<String>()
    
    var images: [UIImage]?
    var tags: [String] = []
    
    
    //let photosList = List<String>()
    //let tagList = List<String>()
    
    convenience init(content: String, location: Place, emotion: EmojiItem, photos: [String]?, images: [UIImage]?) {
        self.init()
        self.content = content
        self.location = location
        self.emotion = emotion
        if let photos = photos {
            photos.forEach { self.photos.append($0) }
        }
        if let images = images {
            self.images = images
        }
    }
}
