//
//  FMServices.swift
//  SwiftfulSavingExample
//
//  Created by Nick Sarno on 5/11/22.
//

import Foundation
import SwiftfulSaving

class FileManagerServices {
    static private let directory = FMDirectory(directory: .cachesDirectory, limitInMB: nil)
    static let images = FMService(directory: directory, folderName: "images", folderLimitInMB: nil, cacheLimitInMB: nil)
    static let models = FMService(directory: directory, folderName: "models", folderLimitInMB: nil, cacheLimitInMB: nil)
    static let general = FMService(directory: directory, folderName: "general", folderLimitInMB: nil, cacheLimitInMB: nil)
}
