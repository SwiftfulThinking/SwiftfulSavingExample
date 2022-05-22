//
//  CDExampleView.swift
//  SwiftfulSavingExample
//
//  Created by Nick Sarno on 5/11/22.
//

import SwiftUI
import SwiftfulSaving

struct CDExampleView: View {
    
    let service = CoreDataServices.instance
    @State private var item: CDItem? = nil
    let itemKey: String = "abc123"
        
    var body: some View {
        List {
            HStack {
                Text("Item title:")
                
                Text(item?.title ?? "n/a")
                    .font(.body)
            }
            
            Button {
                Task {
                    self.item = CDItem(key: itemKey, title: UUID().uuidString)
                }
            } label: {
                Text("Create new Item")
            }
            
            Button {
                Task {
                    self.item = try? await service.object(key: itemKey)
                }
            } label: {
                Text("Fetch from CoreData")
            }
            
            Button {
                Task {
                    guard let item = item else { return }
                    try await service.save(object: item, key: itemKey)
                }
            } label: {
                Text("Save to CoreData")
            }
            
            Button {
                Task {
                    try? await service.delete(key: itemKey, type: CDItem.self)
                }
            } label: {
                Text("Delete from CoreData")
            }
        }
        .font(.headline)
    }
}

struct CDExampleView_Previews: PreviewProvider {
    static var previews: some View {
        CDExampleView()
    }
}
