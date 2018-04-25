//
//  StoryboardManager.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 4/25/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import UIKit

class StoryboardManager {
    static var shared = StoryboardManager()
    
   class Main {
        static let storyboardName = "Main"
        static func getNewPostVC() -> UINavigationController {
            return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: String(describing: "NewPostNavigationVC")) as! UINavigationController
        }
    }
}
