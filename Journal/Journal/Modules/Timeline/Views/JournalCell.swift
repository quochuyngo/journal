//
//  PostCell.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 4/23/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import UIKit
import SnapKit

protocol JournalCellDelegate: class {
    func moreButtonDidTap(_ atJournal: Journal)
}
class JournalCell: UITableViewCell {
    
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var emotionImageView: UIImageView!
    @IBOutlet weak var bgView: UIView!
    
    weak var delegate: JournalCellDelegate?
    
    var journal: Journal!
    
    func configCell(with journal: Journal) {
        self.journal = journal
        contentLabel.text = journal.content
        locationLabel.text = journal.location?.title
        if let emoji = journal.emotion {
            emotionImageView.image = UIImage(named: emoji.icon)
        }
        
        var tagsText = ""
        journal.tags.forEach {
            tagsText += "#\($0) "
        }
        tagLabel.text = tagsText
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.layer.cornerRadius = 6
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func onMoreButtonTap(_ sender: UIButton) {
        delegate?.moreButtonDidTap(journal)
    }
    
}
