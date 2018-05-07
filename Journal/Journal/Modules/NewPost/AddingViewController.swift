//
//  AddingViewController.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 4/30/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos

protocol AddingViewControllerDelegate: class {
    func photosDidSelect(_ assets: [PHAsset])
}
class AddingViewController: UIViewController {

    weak var delegate: AddingViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onAddPhoto(_ sender: UIButton) {
        let vc = BSImagePickerViewController()
        vc.navigationBar.barTintColor = UIColor.mainColor()
        vc.navigationBar.tintColor = UIColor.white
        vc.albumButton.setTitleColor(UIColor.white, for: .normal)
        
        bs_presentImagePickerController(vc, animated: true,
                                        select: { (asset: PHAsset) -> Void in
                                            // User selected an asset.
                                            // Do something with it, start upload perhaps?
        }, deselect: { (asset: PHAsset) -> Void in
            // User deselected an assets.
            // Do something, cancel upload?
        }, cancel: { (assets: [PHAsset]) -> Void in
            // User cancelled. And this where the assets currently selected.
        }, finish: { (assets: [PHAsset]) -> Void in
            self.delegate?.photosDidSelect(assets)
            // User finished with these assets
        }, completion: nil)
    }
    
    @IBAction func onAddPlace(_ sender: UIButton) {
        let vc = StoryboardManager.Main.getPlaceVC()
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func onEmojiAdd(_ sender: UIButton) {
        let vc = StoryboardManager.Main.getMotionVC()
        present(vc, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
