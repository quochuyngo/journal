//
//  CustomTabBar.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 4/25/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import UIKit

protocol CustomBarDelegate: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didTapCenterButton: UIButton)
}

class CustomTabBar: UITabBar {

    private let centerButton = UIButton()
    private let height:CGFloat = 60.0
    weak var customDelegate: CustomBarDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        addCenterButton()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.isHidden {
            return super.hitTest(point, with: event)
        }
        
        let from = point
        let to = centerButton.center
        
        return sqrt((from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)) <= 39 ? centerButton : super.hitTest(point, with: event)
    }

    func addCenterButton() {
        
        centerButton.frame.size = CGSize(width: height, height: height)
        centerButton.backgroundColor = .white
        centerButton.layer.cornerRadius = height/2
        centerButton.layer.masksToBounds = true
        centerButton.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: 16)
        centerButton.addTarget(self, action: #selector(test), for: .touchUpInside)
        centerButton.setImage(UIImage(named: "ic_new_post"), for: .normal)
        centerButton.setBackgroundImage(UIImage(named: "ic_new_post"), for: .normal)
        addSubview(centerButton)
        backgroundColor = .white
    }
    
    @objc func test() {
        customDelegate?.tabBar(self, didTapCenterButton: centerButton)
    }

}
