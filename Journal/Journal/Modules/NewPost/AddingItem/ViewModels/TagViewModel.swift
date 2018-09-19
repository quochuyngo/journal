//
//  TagViewModel.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 9/18/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import RxSwift

class TagViewModel {
    var journal: Journal?
    
    lazy var tags: [String] = []
    
    
    func findAndRemoveSpace(text: String) -> String {
        return text.reduce("") {
            var newText = $0
            if $1 != " " {
                newText.append($1)
            }
            return newText
        }
    }
}
