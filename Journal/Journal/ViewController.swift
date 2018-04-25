//
//  ViewController.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 4/18/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let plainText1 = "By proceeding, you confirm you’re 18+, a Philippines resident & agree to our Terms of use"
//        let linkText1 = "Terms of use"
//        let linkText2 = "Privacy Policy"
//        let plainText2 = ". We may collect, use & disclose your personal data to FNG’s global service providers to administer your FOX+ account."
//
//
//
//
//        let attributedString = NSMutableAttributedString(string: plainText1)
//        attributedString.addAttribute(.foregroundColor, value: UIColor.white, range:NSRange(location: 0, length: plainText1.characters.count) )
//        let attributesPlainText1 = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14.0, weight: .light),
//            NSAttributedStringKey.foregroundColor: UIColor.white]
//        attributedString.setAttributes(attributesPlainText1, range:NSRange(location: 0, length: plainText1.characters.count))
//        let linkAttribute1 = NSMutableAttributedString(string: linkText1)
//
//        let attributes1 = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14.0, weight: .medium),
//            NSAttributedStringKey.link:NSURL(string: "http://apkia.com/")!,
//            NSAttributedStringKey.foregroundColor: UIColor.white,
//            NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue
//            ] as [NSAttributedStringKey : Any]
//        linkAttribute1.setAttributes(attributes1, range: NSRange(location: 0, length: linkText1.characters.count))
//        attributedString.append(linkAttribute1)
//
//        attributedString.append(NSMutableAttributedString(string:" and "))
//
//        let linkAttribute2 = NSMutableAttributedString(string: linkText2)
//
//        let attributes2 = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14.0, weight: .medium),
//                           NSAttributedStringKey.link:NSURL(string: "http://apkia.com/")!,
//                           NSAttributedStringKey.foregroundColor: UIColor.white,
//                           NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue
//            ] as [NSAttributedStringKey : Any]
//
//        linkAttribute2.setAttributes(attributes2, range: NSRange(location: 0, length: linkText2.characters.count))
//        attributedString.append(linkAttribute2)
//
//        let plainText2Attribute = NSMutableAttributedString(string: plainText2)
//        plainText2Attribute.addAttribute(.foregroundColor, value: UIColor.white, range:NSRange(location: 0, length: plainText2.characters.count))
//        attributedString.append(plainText2Attribute)
//
//        textView.linkTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.white]
        
        textView.attributedText = setAttributes()
        textView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setAttributes() -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: "Want to learn iOS? Here")
        
        let attributesPlainText = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14.0, weight: .light),
                                    NSAttributedStringKey.foregroundColor: UIColor.white]
        attributedString.setAttributes(attributesPlainText, range: NSRange(location: 0, length: 19))
        
        let attributesLink = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14.0, weight: .medium),
                           NSAttributedStringKey.link:NSURL(string: "https://www.hackingwithswift.com")!,
                           NSAttributedStringKey.foregroundColor: UIColor.white,
                           NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue
            ] as [NSAttributedStringKey : Any]
        attributedString.addAttributes(attributesLink, range: NSRange(location: 19, length: 4))
        return attributedString
    }
    let url = URL(string:"https://buy.itunes.apple.com/WebObjects/MZFinance.woa/wa/manageSubscriptions")
}

extension ViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        
        UIApplication.shared.openURL(url!)
        return false
    }
    
}

extension UITapGestureRecognizer {
    func didTapAttributeTextInLabel(_ label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
        y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        
        let locationOfTouchInTextContainer = CGPoint(x:locationOfTouchInLabel.x - textContainerOffset.x, y:
                                                         locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}
