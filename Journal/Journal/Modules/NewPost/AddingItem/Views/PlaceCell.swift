//
//  PlaceCell.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 9/2/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import UIKit

class PlaceCell: UITableViewCell {

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var place: Place! {
        didSet {
            titleLabel.text = place.title
            addressLabel.text = place.address
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
