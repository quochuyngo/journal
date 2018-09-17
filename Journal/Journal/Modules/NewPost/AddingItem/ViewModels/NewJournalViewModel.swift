//
//  NewJournalViewModel.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 9/16/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import UIKit
import RealmSwift

class NewJournalViewModel {
    var editJournal: Journal?
    lazy var tempJournal: Journal = Journal()
    lazy var photosRemoved = [String]()
    lazy var photos = [UIImage]()
    lazy var newPhotosAdded = [UIImage]()
    //handle create/edit a journal
    func create(_ journal: Journal) {
        DBManager.default.add(journal)
    }
    
    func edit() {
        guard let journal = editJournal else { return }
        var newPhotos = [String]()
        newPhotosAdded.forEach {
            let name = StorageManager.getNameFor(image: $0)
            StorageManager.save($0, with: name)
            newPhotos.append(name)
        }
        
        photosRemoved.forEach {
            StorageManager.removeImage(with: $0)
        }
        
        print(Array(journal.imagesName))
        let finalList = journal.imagesName.reduce(into: [String]()) {
            (editedPhotos, photo) in
            let filteredList = photosRemoved.filter { photo != $0 }
            return editedPhotos += filteredList
        } + newPhotos
        
        tempJournal.imagesName = DBManager.convertArrayToList(with: finalList)
        tempJournal.id = journal.id
        DBManager.default.update(tempJournal)
    }
    
    func removePhoto(at index: Int) {
        guard let journal = editJournal else { return }
        photosRemoved.append(journal.imagesName[index])
    }

    func isShowPhotoView() -> Bool {
        guard let journal = editJournal else { return false }
        return !((journal.imagesName.count - photosRemoved.count) == 0)
    }
    //handle remove images edited post
    
    //handle add new images edited post 
    
    
}
