//
//  PhotoCell.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 5/6/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    var data: UIImage! {
        didSet {
            imageView.image = data
        }
    }
    @IBOutlet weak var imageView: UIImageView!
}
