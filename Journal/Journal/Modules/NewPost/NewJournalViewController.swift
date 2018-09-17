//
//  NewPostViewController.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 4/25/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import UIKit
import Photos

protocol NewJournalViewControllerDelegate: class {
    func didAddJournal(_ journal: Journal?)
}
class NewJournalViewController: UIViewController {

    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightPhotoCollectionView: NSLayoutConstraint!
    @IBOutlet weak var textView: UITextView!
    let viewModel = NewJournalViewModel()
    var photoVC: PhotoViewController?
    var addingItemVC: AddingItemViewController?
    
    weak var delegate: NewJournalViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.becomeFirstResponder()
        photoView(isShow: false)
        NotificationCenter.default.addObserver(self, selector: #selector(NewJournalViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(NewJournalViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
       configEditJournal()
    }

    deinit {
        print("deinit NewJournal")
    }
    
    func configEditJournal() {
        guard let journal = viewModel.editJournal else { return }
        textView.text = journal.content
        if journal.photos.count > 0 {
            viewModel.photos = journal.photos
            photoVC?.photos = journal.photos
            photoView(isShow: true)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PhotoVCSegue" {
            guard let vc = segue.destination as? PhotoViewController else {
                return
            }
            photoVC = vc
            vc.delegate = self
        } else {
            guard let vc = segue.destination as? AddingItemViewController else {
                return
            }
            addingItemVC = vc
            vc.journal = viewModel.editJournal
            vc.delegate = self
        }
        
    }

    @IBAction func onPost(_ sender: UIBarButtonItem) {
        if let _ = viewModel.editJournal {
            viewModel.tempJournal.content = textView.text
            viewModel.edit()
 
        } else {
            
            if let emoji = viewModel.tempJournal.emotion {
                let journal = Journal(content: textView.text, location: viewModel.tempJournal.location, emotion: emoji, photos: viewModel.photos)
                viewModel.create(journal)
            } else {
                let alert = AlertManager.getAlert(withType: .create, handler: nil)
                present(alert, animated: true, completion: nil)
            }
        }
        delegate?.didAddJournal(nil)
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

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            bottomConstraint.constant = keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        bottomConstraint.constant = 0
    }
    
    func photoView(isShow: Bool) {
        heightPhotoCollectionView.constant = isShow ? 120*ratio : 0
        updateViewConstraints()
    }
}

extension NewJournalViewController: AddingItemViewControllerDelegate {
    func photosDidSelect(_ assets: [PHAsset]) {
        DispatchQueue.global().async { [unowned self] in
            assets.forEach {
                let photo = self.getAssetThumbnail($0)
                self.viewModel.photos.append(photo)
                if let _ = self.viewModel.editJournal {
                    self.viewModel.newPhotosAdded.append(photo)
                }
            }
            DispatchQueue.main.async { [unowned self] in
                print(self.viewModel.photos.count)
                self.photoVC?.photos = self.viewModel.photos
                self.photoView(isShow: self.viewModel.photos.count > 0)
            }
        }
    }
    
    func emojiDidSelect(_ emoji: EmojiItem) {
        viewModel.tempJournal.emotion = emoji
    }
    
    func placeDidSelect(_ place: Place) {
        viewModel.tempJournal.location = place
    }
}

extension NewJournalViewController: PhotoViewControllerDelegate  {
    func photo(didRemoveAt indexPath: IndexPath) {
        // MARK: Handle in ViewModel
        viewModel.photos.remove(at: indexPath.row)
        photoView(isShow: viewModel.photos.count > 0)
    
        if let _ = viewModel.editJournal {
            viewModel.removePhoto(at: indexPath.row)
        } else {
            
        }
    }
}
