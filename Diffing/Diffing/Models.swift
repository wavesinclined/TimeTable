//
//  Models.swift
//  Diffing
//
//  Created by Kaushal on 27/03/18.
//  Copyright © 2018 BusyBear. All rights reserved.
//

import Foundation
import UIKit
import IGListKit

class FeedItem {
    var pk: Int
    var desc: String
    
    init(pk: Int, desc: String) {
        self.pk = pk
        self.desc = desc
    }
}


//OLD: 10, 20, 30, 40
//NEW: 20, 50
//OUT: 10, 20, 30, 40, 50

// newly: 50
// update: 20


extension FeedItem: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return pk as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? FeedItem else { return false }
        return self.pk == object.pk
        //return user.isEqual(toDiffableObject: object.user) && comments == object.comments
    }
}

