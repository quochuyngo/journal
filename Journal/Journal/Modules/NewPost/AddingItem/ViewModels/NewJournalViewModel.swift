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
    
    func update() {
        updateJournal()
        DBManager.default.update(tempJournal)
    }
    
    //handle remove images edited post
    func removePhoto(at index: Int) {
        guard let journal = editJournal else { return }
        photosRemoved.append(journal.imagesName[index])
    }

    func isShowPhotoView() -> Bool {
        guard let journal = editJournal else { return false }
        return !((journal.imagesName.count - photosRemoved.count) == 0)
    }
    
    
    private func updateJournal() {
        guard let editJournal = editJournal else { return }
        
        var newPhotos = [String]()
        newPhotosAdded.forEach {
            let name = StorageManager.getNameFor(image: $0)
            StorageManager.save($0, with: name)
            newPhotos.append(name)
        }
        
        photosRemoved.forEach {
            StorageManager.removeImage(with: $0)
        }
        
        let finalListPhotos =  ((photosRemoved.count == 0) ? editJournal.imagesName.toArray() : photosArrayAfterRemoved(photosOrigin: editJournal.imagesName.toArray(), photosRemoved: photosRemoved)) + newPhotos
        
        tempJournal.id = editJournal.id
        tempJournal.imagesName = finalListPhotos.toList()
        tempJournal.datetimeEdited = editJournal.datetimeEdited
        
        
        if tempJournal.emotion == nil {
            tempJournal.emotion = editJournal.emotion
        }
        
        if tempJournal.location == nil {
            tempJournal.location = editJournal.location
        }
        
        if tempJournal.tags.count == 0 {
            tempJournal.tags = editJournal.tags
        }
    }
    //handle add new images edited post
    private func photosArrayAfterRemoved(photosOrigin: [String], photosRemoved: [String]) -> [String] {
       var newList = [String]()
        for i in 0..<photosOrigin.count {
            photosRemoved.forEach {
                if $0 != photosOrigin[i] {
                   newList.append(photosOrigin[i])
                }
            }
        }
        return newList
    }
}
