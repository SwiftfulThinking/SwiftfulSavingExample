//
//  FMCodableView.swift
//  SwiftfulSavingExample
//
//  Created by Nick Sarno on 5/22/22.
//

import Foundation
import SwiftUI
import SwiftfulSaving

struct UserModel: Codable, URLTransformable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

struct FMCodableView: View {
    
    let service = FileManagerServices.models
    @State private var model: UserModel? = nil
    let key: String = "test123"
        
    var body: some View {
        List {
            HStack {
                Text("Codable:")
                
                if let model = model {
                    VStack(alignment: .leading) {
                        Text(model.title).font(.title)
                        Text(model.body).font(.subheadline)
                        Text("ID: \(model.id)")
                    }
                } else {
                    Text("n/a")
                        .font(.body)
                }
            }
            
            Button {
                Task {
                    guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else { return }
                    if let (data, _) = try? await URLSession.shared.data(from: url, delegate: nil) {
                        self.model = try? JSONDecoder().decode(UserModel.self, from: data)
                    }
                }
            } label: {
                Text("Download from Remote")
            }
            
            Button {
                Task {
                    do {
                        self.model = try await service.object(key: key)
                    } catch {
                        self.model = nil
                    }
                }
            } label: {
                Text("Fetch from FileManager")
            }
            
            Button {
                Task {
                    guard let model = model else { return }
                    try await service.save(object: model, key: key)
                }
            } label: {
                Text("Save to FileManager")
            }
            
            Button {
                Task {
                    try? await service.delete(key: key, ext: UserModel.fileExtension)
                }
            } label: {
                Text("Delete from FileManager")
            }
        }
        .font(.headline)
    }
}

struct FMCodableView_Previews: PreviewProvider {
    static var previews: some View {
        FMCodableView()
    }
}
