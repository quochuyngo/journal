//
//  FileManager.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 9/3/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//
import UIKit
class StorageManager {
    class func save(_ image: UIImage, with imageName: String) {
        if let data = UIImagePNGRepresentation(image) {
            let fileName = StorageManager.getDocumentsDirectory().appendingPathComponent(imageName)
            try! data.write(to: fileName)
        }
    }
    
    class func getImage(with imageName: String) -> UIImage? {
        let imagePath = StorageManager.getDocumentsDirectory().appendingPathComponent(imageName)
        if FileManager.default.fileExists(atPath: imagePath.path) {
            return UIImage(contentsOfFile: imagePath.path)
        }
        return nil
    }
    private class func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
