//
//  CustomTabController.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 4/25/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import UIKit

class CustomTabController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        (tabBar as! CustomTabBar).customDelegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CustomTabController: CustomBarDelegate {
    func tabBar(_ tabBar: UITabBar, didTapCenterButton: UIButton) {
        let vc = StoryboardManager.Main.getNewPostVC()
        present(vc, animated: true, completion: nil)
    }
}
