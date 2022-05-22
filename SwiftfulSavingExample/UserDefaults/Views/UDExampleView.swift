//
//  UDExampleView.swift
//  SwiftfulSavingExample
//
//  Created by Nick Sarno on 5/22/22.
//

import Foundation
import SwiftUI
import SwiftfulSaving

struct UDExampleView: View {
    
    let service = UserDefaultServices.instance
    @State private var title: String? = nil
    let itemKey: String = "testing123"
        
    var body: some View {
        List {
            HStack {
                Text("Title:")
                
                Text(title ?? "n/a")
                    .font(.body)
            }
            
            Button {
                Task {
                    self.title = UUID().uuidString
                }
            } label: {
                Text("Create new Title")
            }
            
            Button {
                Task {
                    self.title = try? await service.object(key: itemKey)
                }
            } label: {
                Text("Fetch from UserDefaults")
            }
            
            Button {
                Task {
                    guard let title = title else { return }
                    await service.save(object: title, key: itemKey)
                }
            } label: {
                Text("Save to UserDefaults")
            }
            
            Button {
                Task {
                    await service.delete(key: itemKey)
                }
            } label: {
                Text("Delete from UserDefaults")
            }
        }
        .font(.headline)
    }
}

struct UDExampleView_Previews: PreviewProvider {
    static var previews: some View {
        UDExampleView()
    }
}
