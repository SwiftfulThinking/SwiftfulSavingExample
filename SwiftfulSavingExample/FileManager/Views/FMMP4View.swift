//
//  FMMP4View.swift
//  SwiftfulSavingExample
//
//  Created by Nick Sarno on 5/22/22.
//

import Foundation
import SwiftUI
import SwiftfulSaving
import AVKit

// Free mp4 from: https://www.videezy.com/abstract/44249-particle-strings-background-video
struct FMMP4View: View {
    
    let service = FileManagerServices.general
    @State private var player: AVPlayer? = nil
    @State private var url: URL.MP4? = nil {
        didSet {
            guard let url = url else {
                player = nil
                return
            }
            player = AVPlayer(url: url.url)
        }
    }
    let key: String = "stringsvideo"

    var body: some View {
        List {
            HStack {
                Text("MP4:")
                
                if let player = player {
                    VideoPlayer(player: player)
                        .frame(height: 300)
                } else {
                    Text("n/a")
                        .font(.body)
                }
            }
            
            Button {
                Task {
                    guard let fileUrl = Bundle.main.url(forResource: key, withExtension: ".mp4") else { return }
                    self.url = URL.MP4(url: fileUrl)
                }
            } label: {
                Text("Load from Bundle")
            }
            
            Button {
                Task {
                    do {
                        self.url = try await service.object(key: key)
                    } catch {
                        self.url = nil
                    }
                }
            } label: {
                Text("Fetch from FileManager")
            }
            
            Button {
                Task {
                    guard let url = url else { return }
                    try await service.save(object: url, key: key)
                }
            } label: {
                Text("Save to FileManager")
            }
            
            Button {
                Task {
                    try? await service.delete(key: key, ext: URL.MP4.fileExtension)
                }
            } label: {
                Text("Delete from FileManager")
            }
        }
        .font(.headline)
    }
}

struct FMMP4View_Previews: PreviewProvider {
    static var previews: some View {
        FMMP4View()
    }
}
