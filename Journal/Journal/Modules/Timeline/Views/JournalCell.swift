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
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var heightImageViewContainerContstraint: NSLayoutConstraint!
    
    weak var delegate: JournalCellDelegate?
    
    var journal: Journal!
    
    func configCell(with journal: Journal) {
        self.journal = journal
        imageContainerView.subviews.forEach {
            $0.removeFromSuperview()
        }
        contentLabel.text = journal.content
        if journal.photos.count > 0 {
            let view = PostImageView1.initFromNib()
            imageContainerView.addSubview(view)
            view.snp.makeConstraints { make -> Void in
                make.edges.equalToSuperview()
            }
            view.imageView.image = journal.photos.first
            heightImageViewContainerContstraint.constant = 190
        } else {
            heightImageViewContainerContstraint.constant = 0
        }
        locationLabel.text = journal.location?.title
        if let emoji = journal.emotion {
            emotionImageView.image = UIImage(named: emoji.icon)
        }
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

//            } else {
//                if data == 3 {
//                    let view = PostImageView3.initFromNib()
//                    imageContainerView.addSubview(view)
//                    view.snp.makeConstraints { make -> Void in
//                        make.edges.equalToSuperview()
//                    }
//                } else {
//                    let view = PostImageView2.initFromNib()
//                    imageContainerView.addSubview(view)
//                    view.snp.makeConstraints { make -> Void in
//                        make.edges.equalToSuperview()
//                    }
//                }
//
//            }
