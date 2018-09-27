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
    func photoDidTapAt(_ index: Int)
}
class JournalCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var emotionImageView: UIImageView!
    @IBOutlet weak var bgView: UIView!
    
    weak var delegate: JournalCellDelegate?
    var index: Int!
    var journal: Journal!
    
    func configCell(at index: Int, with journal: Journal) {
        self.journal = journal
        self.index = index
        contentLabel.text = journal.content
        locationLabel.text = journal.location?.title
        if let emoji = journal.emotion {
            emotionImageView.image = UIImage(named: emoji.icon)?.withRenderingMode(.alwaysTemplate)
            emotionImageView.tintColor = UIColor.mainColor()
        }
        dateLabel.text = journal.formatDate()
        timeLabel.text = journal.formatTime()
        var tagsText = ""
        journal.tags.forEach {
            tagsText += "#\($0) "
        }
        tagLabel.text = tagsText
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.layer.cornerRadius = 4
        bgView.layer.masksToBounds = false
        bgView.layer.shadowRadius = 1.5
        bgView.layer.shadowOpacity = 0.4
        bgView.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        bgView.layer.shadowColor = UIColor(red:  121/255, green:  121/255, blue:  121/255, alpha: 1).cgColor
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
