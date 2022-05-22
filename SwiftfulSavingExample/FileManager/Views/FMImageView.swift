//
//  FMImageView.swift
//  SwiftfulSavingExample
//
//  Created by Nick Sarno on 5/11/22.
//

import SwiftUI
import SwiftfulSaving

struct FMImageView: View {
    
    let service = FileManagerServices.images
    @State private var image: UIImage? = nil
    let imageKey: String = "abc123"
        
    var body: some View {
        List {
            HStack {
                Text("Image:")
                
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                } else {
                    Text("n/a")
                        .font(.body)
                }
            }
            
            Button {
                Task {
                    guard let url = URL(string: "https://picsum.photos/200") else { return }
                    if let (data, _) = try? await URLSession.shared.data(from: url, delegate: nil) {
                        self.image = UIImage(data: data)
                    }
                }
            } label: {
                Text("Download from Remote")
            }
            
            Button {
                Task {
                    do {
                        let jpg: UIImage.JPG = try await service.object(key: imageKey)
                        self.image = jpg.image
                    } catch {
                        self.image = nil
                    }
                }
            } label: {
                Text("Fetch from FileManager")
            }
            
            Button {
                Task {
                    guard let image = image else { return }
                    try await service.save(object: image.jpg(compression: 1), key: imageKey)
                }
            } label: {
                Text("Save to FileManager")
            }
            
            Button {
                Task {
                    try? await service.delete(key: imageKey, ext: ImageJPG.fileExtension)
                }
            } label: {
                Text("Delete from FileManager")
            }
        }
        .font(.headline)
    }
}

struct FMImageView_Previews: PreviewProvider {
    static var previews: some View {
        FMImageView()
    }
}
