//
//  PostCell.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 4/23/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import UIKit
import SnapKit

class PostCell: UITableViewCell {

    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var heightImageViewContainerContstraint: NSLayoutConstraint!
    var data: Int! {
        didSet {
            if data % 2 == 0 {
                let view = PostImageView1.initFromNib()
                imageContainerView.addSubview(view)
                view.snp.makeConstraints { make -> Void in
                    make.edges.equalToSuperview()
                }
                
                if data == 0 {
                    heightImageViewContainerContstraint.constant = 0
                }
            } else {
                if data == 3 {
                    let view = PostImageView3.initFromNib()
                    imageContainerView.addSubview(view)
                    view.snp.makeConstraints { make -> Void in
                        make.edges.equalToSuperview()
                    }
                } else {
                    let view = PostImageView2.initFromNib()
                    imageContainerView.addSubview(view)
                    view.snp.makeConstraints { make -> Void in
                        make.edges.equalToSuperview()
                    }
                }
                
            }
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
