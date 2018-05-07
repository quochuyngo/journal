//
//  NewPostViewController.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 4/25/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import UIKit
import Photos

class NewPostViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var photoVC: PhotoViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
//        textView.contentSize = CGSize(width: widthScreen, height: textView.frame.height + 50)
//        textView.contentOffset = CGPoint(x: 0, y: -50)
        //navigationController?.navigationBar.
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PhotoVCSegue" {
            guard let vc = segue.destination as? PhotoViewController else {
                return
            }
            photoVC = vc
        } else {
            guard let vc = segue.destination as? AddingViewController else {
                return
            }
            vc.delegate = self
        }
        
    }

    @IBAction func onPost(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func getAssetThumbnail(_ asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
            thumbnail = result!
        })
        return thumbnail
    }

}

extension NewPostViewController: AddingViewControllerDelegate {
    func photosDidSelect(_ assets: [PHAsset]) {
        DispatchQueue.global().async { [unowned self] in
            var photos = [UIImage]()
            assets.forEach {
                photos.append(self.getAssetThumbnail($0))
            }
            DispatchQueue.main.async { [unowned self] in
                self.photoVC?.photos = photos
            }
        }
    }
    
}
