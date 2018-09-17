//
//  AddEmojiViewController.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 5/5/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import UIKit

protocol EmotionViewControllerDelegate: class {
    func didSelect(_ emoji: EmojiItem)
}
class EmotionViewController: UIViewController {

    let emojiList = [EmojiItem(.happy), EmojiItem(.bad), EmojiItem(.excited), EmojiItem(.cool), EmojiItem(.angry), EmojiItem(.awful)]
    weak var delegate: EmotionViewControllerDelegate?
    @IBOutlet weak var collectionView: UICollectionView!
    var emoji: EmojiItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        setupEmoji()
    }

    func setupEmoji() {
        guard let emoji = emoji else { return }
        for i in 0..<emojiList.count {
            if emojiList[i].type == emoji.type {
                emojiList[i].isSelected = true
                collectionView.reloadData()
            }
        }
    }
    deinit {
        print("deinit EmotionVC")
    }
    
    @IBAction func onCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onDone(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension EmotionViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojiList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: EmotionCell.self), for: indexPath) as! EmotionCell
        cell.item = emojiList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelect(emojiList[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: widthScreen/2 - 0.25 , height: widthScreen/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
}
