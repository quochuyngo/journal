//
//  PhotoCell.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 5/6/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import UIKit

protocol PhotoCellDelegate: class {
    func onRemovePhoto(at indexPath: IndexPath)
}

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var removeButton: UIButton!
    
    var data: UIImage! {
        didSet {
            imageView.image = data
        }
    }
    var indexPath: IndexPath!
    weak var delegate: PhotoCellDelegate?
    
    @IBAction func onRemove(_ sender: UIButton) {
        delegate?.onRemovePhoto(at: indexPath)
    }
}
