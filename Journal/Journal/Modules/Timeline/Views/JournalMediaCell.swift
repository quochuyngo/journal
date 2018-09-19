//
//  JournalMediaCell.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 9/19/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import UIKit

class JournalMediaCell: JournalCell {
    @IBOutlet weak var heightImageViewContainerContstraint: NSLayoutConstraint!
    @IBOutlet weak var imageContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func configCell(with journal: Journal) {
        super.configCell(with: journal)
        
        imageContainerView.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        let view = PostImageView1.initFromNib()
        imageContainerView.addSubview(view)
        view.snp.makeConstraints { make -> Void in
            make.edges.equalToSuperview()
        }
        view.imageView.image = journal.photos.first
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

