//
//  FMImageStreamableView.swift
//  SwiftfulSavingExample
//
//  Created by Nick Sarno on 5/22/22.
//

import Foundation
import SwiftUI
import SwiftfulSaving

class ImageManager {
    @FMStreamable(key: "streamable123", service: FileManagerServices.images) var image: UIImage.JPG? = nil
}

class FMImageStreamableViewModel: ObservableObject {
    
    let manager = ImageManager()
    @MainActor @Published var image: UIImage? = nil
    
    init() {
        addStreams()
    }
    
    func addStreams() {
        Task {
            for await value in manager.$image.values {
                await MainActor.run(body: {
                    self.image = value?.image
                })
            }
        }
    }
    
    func saveImage(image: UIImage.JPG?) {
        manager.image = image
    }
    
}

struct FMImageStreamableView: View {
    
    @StateObject private var viewModel = FMImageStreamableViewModel()
        
    var body: some View {
        List {
            HStack {
                Text("Image:")
                
                if let image = viewModel.image {
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
                        viewModel.saveImage(image: UIImage.JPG(data: data))
                    }
                }
            } label: {
                Text("Download Remote & Save to FileManager")
            }
            
            Button {
                viewModel.image = nil
            } label: {
                Text("Delete from FileManager")
            }
        }
        .font(.headline)
    }
}

struct FMImageStreamableView_Previews: PreviewProvider {
    static var previews: some View {
        FMImageStreamableView()
    }
}
