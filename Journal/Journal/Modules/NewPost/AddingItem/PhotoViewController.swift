//
//  PhotoViewController.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 5/5/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import UIKit
import SnapKit

protocol PhotoViewControllerDelegate: class {
    func photo(didRemoveAt indexPath: IndexPath)
}
class PhotoViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate: PhotoViewControllerDelegate?
    
    var photos: [UIImage]? {
        didSet {
            collectionView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("deinit PhotoVC")
    }
}

extension PhotoViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let photos = photos else {
            return 0
        }
        print(photos.count)
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotoCell.self), for: indexPath) as! PhotoCell
        cell.data = photos?[indexPath.row]
        cell.indexPath = indexPath
        cell.delegate = self
        return cell
    }
}

extension PhotoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        return CGSize(width: height, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}

extension PhotoViewController: PhotoCellDelegate {
    func onRemovePhoto(at indexPath: IndexPath) {
        photos?.remove(at: indexPath.row)
        delegate?.photo(didRemoveAt: indexPath)
        if photos?.count != 0 {
            collectionView.reloadData()
        }
    }
}
