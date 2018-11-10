//
//  FileManager.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 9/3/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//
import UIKit

enum JPEGQuality: CGFloat {
    case lowest  = 0
    case low     = 0.25
    case medium  = 0.5
    case high    = 0.75
    case highest = 1
}

class StorageManager {
    class func save(_ image: UIImage, with name: String) {
        if let data = UIImageJPEGRepresentation(image, JPEGQuality.medium.rawValue) {
            let imagePath = StorageManager.path(for: name)
            try! data.write(to: imagePath)
        }
    }
    
    class func getImage(with name: String) -> UIImage? {
        let imagePath = StorageManager.path(for: name)
        if FileManager.default.fileExists(atPath: imagePath.path) {
            return UIImage(contentsOfFile: imagePath.path)
        }
        return nil
    }
    
    class func removeImage(with name: String) {
        let imagePath = StorageManager.path(for: name)
        do {
            if FileManager.default.fileExists(atPath: imagePath.path) {
                try FileManager.default.removeItem(at: imagePath)
            }
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
    
    private class func path(for imageName: String) -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent(imageName)
    }
    
    class func getNameFor(image: UIImage) -> String {
        let photoId = UUID().uuidString
        return "\(photoId).jpeg"
    }
}
