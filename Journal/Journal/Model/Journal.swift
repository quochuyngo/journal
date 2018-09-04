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
    let photosName = List<String>()
    
    var images: [UIImage] {
        return getImagesFromName()
    }
    var tags: [String] = []
    
    convenience init(content: String, location: Place, emotion: EmojiItem, images: [UIImage]?) {
        self.init()
        self.content = content
        self.location = location
        self.emotion = emotion
        if let images  = images {
            setName(for: images)
        }
    }
    
    func setName(for images: [UIImage]) {
        images.forEach {
            let index = images.index(of: $0) ?? 0
            let name = "\(id)-\(index).png"
            photosName.append(name)
            StorageManager.save($0, with: name)
        }
    }
    
    func getImagesFromName() -> [UIImage] {
        var images = [UIImage]()
        photosName.forEach {
            if let image = StorageManager.getImage(with: $0) {
                images.append(image)
            }
        }
        return images
    }
}
