//
//  SwiftfulSavingExampleApp.swift
//  SwiftfulSavingExample
//
//  Created by Nick Sarno on 5/2/22.
//

import SwiftUI
import SwiftfulSaving

@main
struct SwiftfulSavingExampleApp: App {
    
    init() {
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        SwiftfulSaving.addLogging(service: .coreData, actions: [.read, .write, .delete, .notFound])
        SwiftfulSaving.addLogging(service: .fileManager, actions: [.read, .write, .delete, .notFound])
        SwiftfulSaving.addLogging(service: .keychain, actions: [.read, .write, .delete, .notFound])
        SwiftfulSaving.addLogging(service: .userDefaults, actions: [.read, .write, .delete, .notFound])
        SwiftfulSaving.addLogging(service: .nsCache, actions: [.read, .write, .delete, .notFound])
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
