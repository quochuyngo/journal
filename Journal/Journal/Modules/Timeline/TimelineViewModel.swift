//
//  TimelineViewModel.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 9/9/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//
import RealmSwift
import NYTPhotoViewer

class TimelineViewModel {
    var journalList: [Journal] {
        return sortByDate(DBManager.default.getListJournal())
    }
    
    var photos: [PhotoBox] {
        return getPhotosAt(selectedIndex)
    }
    
    var selectedJournal: Journal?
    var selectedIndex: Int!
    
    
    init() {
    
    }
    
    private func sortByDate(_ journals: [Journal]) -> [Journal] {
        return journals.sorted { $0.datetimeEdited! > $1.datetimeEdited! }
    }
    
    func add(_ journal: Journal) {
        DBManager.default.add(journal)
    }
    
    func delete(_ journal: Journal) {
        journal.removeAllImages()
        DBManager.default.delete(journal)
    }
    
    private func getPhotosAt(_ index: Int) -> [PhotoBox] {
        var photos = [PhotoBox]()
        journalList[index].photos.forEach {
            photos.append(PhotoBox($0))
        }
        return photos
    }
}

class PhotoBox: NSObject, NYTPhoto {
    
    init(_ image: UIImage) {
        self.image = image
    }
    var image: UIImage?
    var imageData: Data?
    var placeholderImage: UIImage?
    
    var attributedCaptionTitle: NSAttributedString?
    var attributedCaptionSummary: NSAttributedString?
    var attributedCaptionCredit: NSAttributedString?
}
