//
//  MotionCell.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 5/5/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import UIKit

class EmotionCell: UICollectionViewCell {
    
    @IBOutlet weak var emotionTitle: UILabel!
    @IBOutlet weak var emotionImageView: UIImageView!
    
    var item: EmojiItem! {
        didSet {
            emotionTitle.text = item.type.rawValue
            emotionImageView.image = UIImage(named: item.icon)
        }
    }
}
