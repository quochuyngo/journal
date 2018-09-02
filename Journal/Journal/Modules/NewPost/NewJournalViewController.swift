//
//  NewPostViewController.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 4/25/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import UIKit
import Photos

protocol NewJournalViewControllerDelegate {
    func didAdd(_ journal: Journal)
}
class NewJournalViewController: UIViewController {

    @IBOutlet weak var heightPhotoCollectionView: NSLayoutConstraint!
    @IBOutlet weak var textView: UITextView!
    var photoVC: PhotoViewController?
    var delegate: NewJournalViewControllerDelegate?
    var photos: [UIImage]?
    var emoji: EmojiItem?
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.becomeFirstResponder()
        heightPhotoCollectionView.constant = 0
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PhotoVCSegue" {
            guard let vc = segue.destination as? PhotoViewController else {
                return
            }
            photoVC = vc
        } else {
            guard let vc = segue.destination as? AddingItemViewController else {
                return
            }
            vc.delegate = self
        }
        
    }

    @IBAction func onPost(_ sender: UIBarButtonItem) {
        if let emoji = emoji {
            let journal = Journal(content: textView.text, location: "", emotion: emoji, photos: nil, images: photos)
            delegate?.didAdd(journal)
        }
        
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func getAssetThumbnail(_ asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        option.resizeMode = .exact
        manager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: option, resultHandler: {(result, info)->Void in
            thumbnail = result!
        })
        return thumbnail
    }

}

extension NewJournalViewController: AddingItemViewControllerDelegate {
    func photosDidSelect(_ assets: [PHAsset]) {
        DispatchQueue.global().async { [unowned self] in
            var photos = [UIImage]()
            assets.forEach {
                photos.append(self.getAssetThumbnail($0))
            }
            DispatchQueue.main.async { [unowned self] in
                self.photos = photos
                self.photoVC?.photos = photos
                if photos.count > 0 {
                    self.heightPhotoCollectionView.constant = 120*ratio
                    let name = assets[0].value(forKey: "filename") as! String
                    try! ImageStore.store(image: photos[0], name: name)
                }
            }
        }
    }
    
    func emojiDidSelect(_ emoji: EmojiItem) {
        self.emoji = emoji
    }
}
