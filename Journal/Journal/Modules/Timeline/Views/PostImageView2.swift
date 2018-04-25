//
//  PostImageView2.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 4/24/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import UIKit

class PostImageView2: UIView {

    @IBOutlet var arrayImageView: [UIImageView]!
    
    static func initFromNib() -> PostImageView2 {
        let view = Bundle.main.loadNibNamed( String(describing: PostImageView2.self), owner: nil, options: nil)![0] as! PostImageView2
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
