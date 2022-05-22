//
//  CDServices.swift
//  SwiftfulSavingExample
//
//  Created by Nick Sarno on 5/11/22.
//

import Foundation
import SwiftfulSaving

class CoreDataServices {
    static private let container = CDContainer(name: "CDItemContainer")
    static let instance = CDService(container: container, contextName: "examples", cacheLimitInMB: nil)
}
