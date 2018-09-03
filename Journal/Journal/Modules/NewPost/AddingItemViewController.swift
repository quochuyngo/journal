//
//  AddingViewController.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 4/30/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos

protocol AddingItemViewControllerDelegate: class {
    func photosDidSelect(_ assets: [PHAsset])
    func emojiDidSelect(_ emoji: EmojiItem)
    func placeDidSelect(_ place: Place)
}

class AddingItemViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate: AddingItemViewControllerDelegate?
    var listItem: [AddingItem] = [AddingItem(.location), AddingItem(.emotion), AddingItem(.tag), AddingItem(.camera)]
    var currentItemSelected: AddingItem?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        if let collectionViewFlow = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewFlow.scrollDirection = .horizontal
        }
        
    }

    func addPhoto() {
        let vc = BSImagePickerViewController()
        vc.navigationBar.barTintColor = UIColor.mainColor()
        vc.navigationBar.tintColor = UIColor.white
        vc.albumButton.setTitleColor(UIColor.white, for: .normal)
        
        bs_presentImagePickerController(vc, animated: true,
                                        select: { (asset: PHAsset) -> Void in
                                            // User selected an asset.
                                            // Do something with it, start upload perhaps?
        }, deselect: { (asset: PHAsset) -> Void in
            // User deselected an assets.
            // Do something, cancel upload?
        }, cancel: { (assets: [PHAsset]) -> Void in
            // User cancelled. And this where the assets currently selected.
        }, finish: { (assets: [PHAsset]) -> Void in
            
            self.delegate?.photosDidSelect(assets)
            // User finished with these assets
        }, completion: nil)
    }
    
    func addPlace() {
        let nav = StoryboardManager.Main.getPlaceVC()
        if let vc = nav.viewControllers.first as? PlaceViewController {
            vc.delegate = self
        }
        present(nav, animated: true, completion: nil)
    }
    
    @IBAction func onEmojiAdd(_ sender: UIButton) {
        let nav = StoryboardManager.Main.getMotionVC()
        if let vc = nav.viewControllers.first as? EmotionViewController {
            vc.delegate = self
        }
        present(nav, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension AddingItemViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AddingCell.self), for: indexPath) as! AddingCell
        cell.item = listItem[indexPath.row]
        return cell
    }
}

extension AddingItemViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90*ratio, height: 56)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        currentItemSelected = listItem[indexPath.row]
        switch listItem[indexPath.row].itemType {
        case .location:
            addPlace()
            break
        case .emotion:
            let nav = StoryboardManager.Main.getMotionVC()
            if let vc = nav.viewControllers.first as? EmotionViewController {
                vc.delegate = self
                present(nav, animated: true, completion: nil)
            }
            break
        case .tag:
            break
        case .camera:
            addPhoto()
            break
        }
        listItem[indexPath.row].isSelected = true
        collectionView.reloadData()
    }
}

extension AddingItemViewController: EmotionViewControllerDelegate {
    func didSelect(_ emoji: EmojiItem) {
//        if currentItemSelected != nil {
//            currentItemSelected?.isSelected = true
//            collectionView.reloadData()
//        }
        delegate?.emojiDidSelect(emoji)
    }
}

extension AddingItemViewController: PlaceViewControllerDelegate {
    func didSelectPlace(_ place: Place) {
        delegate?.placeDidSelect(place)
    }
}
