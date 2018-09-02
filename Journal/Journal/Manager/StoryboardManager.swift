//
//  StoryboardManager.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 4/25/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import UIKit

class StoryboardManager {
    
   class Main {
        static let storyboardName = "Main"
        static func getNewPostVC() -> UINavigationController {
            return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: String(describing: "NewJournalNavigationVC")) as! UINavigationController
        }
    
        static func getAddingItemVC() -> UIViewController {
            return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: String(describing: String(describing: AddingItemViewController.self)))
        }
    
        static func getMotionVC() -> UINavigationController {
            return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: String(describing: "EmotionNavigationVC")) as! UINavigationController
        }
    
        static func getPlaceVC() -> UINavigationController {
            return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: String(describing: "PlaceNavigationVC")) as! UINavigationController
        }
    }
}
