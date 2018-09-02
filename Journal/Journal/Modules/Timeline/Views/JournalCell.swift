//
//  PostCell.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 4/23/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import UIKit
import SnapKit

class JournalCell: UITableViewCell {

    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var emotionImageView: UIImageView!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var heightImageViewContainerContstraint: NSLayoutConstraint!
    
    var data: Journal! {
        didSet {
            contentLabel.text = data.content
            if let photos = data.images {
                let view = PostImageView1.initFromNib()
                imageContainerView.addSubview(view)
                view.snp.makeConstraints { make -> Void in
                    make.edges.equalToSuperview()
                }
                view.imageView.image = photos.first!
            } else {
                heightImageViewContainerContstraint.constant = 0
            }
            
            emotionImageView.image = UIImage(named: data.emotion.icon)
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
    
}
