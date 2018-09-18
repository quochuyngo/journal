//
//  Journal.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 5/10/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import RealmSwift

let realm = try! Realm()
class Journal: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var content: String? = ""
    @objc dynamic var location: Place? = Place()
    @objc dynamic var emotion: EmojiItem? = EmojiItem(.happy)
    @objc dynamic var datetimeEdited: Date? = Date()
    var imagesName = List<String>()
    var tags = List<String>()
    
    var photos: [UIImage] {
        get {
            return getImages(from: imagesName)
        }
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(content: String, location: Place?, emotion: EmojiItem, photos: [UIImage]?) {
        self.init()
        self.content = content
        self.location = location
        self.emotion = emotion
        if let photos  = photos {
            setName(for: photos)
        }
    }
    
    func setName(for images: [UIImage]) {
        images.forEach {
            let imageId = UUID().uuidString
            let name = "\(imageId).jpeg"
            imagesName.append(name)
            StorageManager.save($0, with: name)
        }
    }
    
    private func getImages(from imagesName: List<String>) -> [UIImage] {
        var images = [UIImage]()
        imagesName.forEach {
            if let image = StorageManager.getImage(with: $0) {
                images.append(image)
            }
        }
        return images
    }
    
    func removeAllImages() {
        imagesName.forEach {
            StorageManager.removeImage(with: $0)
        }
    }
}

extension Journal {
    func formatFullDateTime() -> String {
        let formater = DateFormatter()
        formater.dateFormat = "dd/MM/yyy HH:mm"
        return formater.string(from: datetimeEdited!)
    }
    
    func formatDate() -> String {
        let formater = DateFormatter()
        formater.dateFormat = "MMM dd"
        return formater.string(from: datetimeEdited!)
    }
}
