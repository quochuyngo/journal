//
//  PostImageView1.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 4/24/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import UIKit

class PostImageView1: UIView {

    @IBOutlet weak var imageView: UIImageView!
    
    static func initFromNib() -> PostImageView1 {
        let view = Bundle.main.loadNibNamed( String(describing: PostImageView1.self), owner: nil, options: nil)![0] as! PostImageView1
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
