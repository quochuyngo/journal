//
//  TagCell.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 9/18/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import UIKit
protocol TagCellDelegate: class {
    func didDeleteTagAt(_ index: Int )
}
class TagCell: UITableViewCell {

    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var tagLabel: UILabel!
    weak var delegate: TagCellDelegate?
    var index: Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        removeButton.setTitleColor(UIColor.mainColor(), for: .normal)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(at index: Int, tag: String) {
        self.index = index
        tagLabel.text = "#\(tag)"
    }

    @IBAction func onDeleteTap(_ sender: UIButton) {
        if let index = index {
            delegate?.didDeleteTagAt(index)
        }
    }
}
