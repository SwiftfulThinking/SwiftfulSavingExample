//
//  CDItem.swift
//  SwiftfulSavingExample
//
//  Created by Nick Sarno on 5/11/22.
//

import Foundation
import SwiftfulSaving

extension CDItemEntity: CoreDataIdentifiable { }

struct CDItem: CoreDataTransformable {
    typealias Entity = CDItemEntity

    let title: String
    let key: String

    init(key: String, title: String) {
        self.key = key
        self.title = title
    }

    init?(from object: Entity) {
        guard let key = object.key, let title = object.title else { return nil }
        self.title = title
        self.key = key
    }
        
    func updatingValues(forEntity entity: inout Entity) {
        entity.title = title
    }
    
}
