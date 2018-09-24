//
//  AddingCell.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 5/10/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import UIKit

class AddingCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var item: AddingItem? {
        didSet {
            guard let item = item else { return }
            iconImageView.image = UIImage(named: item.icon)
            
        }
    }
    override func awakeFromNib() {
        titleLabel.isHidden = true
    }
    
    
}
