//
//  PostImageView3.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 4/25/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import UIKit

class PostImageView3: UIView {

    @IBOutlet var arrayImageView: [UIImageView]!
    static func initFromNib() -> PostImageView3 {
        let view = Bundle.main.loadNibNamed( String(describing: PostImageView3.self), owner: nil, options: nil)![0] as! PostImageView3
        return view
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
