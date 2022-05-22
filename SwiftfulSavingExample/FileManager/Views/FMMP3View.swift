//
//  FMMP3View.swift
//  SwiftfulSavingExample
//
//  Created by Nick Sarno on 5/22/22.
//

import Foundation
import SwiftUI
import SwiftfulSaving
import AVKit

// Free mp3 from: https://www.freesoundslibrary.com/birds-chirping-sound-effect/
struct FMMP3View: View {
    
    let service = FileManagerServices.general
    @State private var player: AVAudioPlayer? = nil
    @State private var url: URL.MP3? = nil {
        didSet {
            guard let url = url else {
                player = nil
                return
            }
            player = try? AVAudioPlayer(contentsOf: url.url)
        }
    }
    let key: String = "Birds-chirping-sound-effect"

    var body: some View {
        List {
            HStack {
                Text("MP3:")
                
                if let player = player {
                    Button("Play / Pause") {
                        if player.isPlaying {
                            player.pause()
                        } else {
                            player.play()
                        }
                    }
                } else {
                    Text("n/a")
                        .font(.body)
                }
            }
            
            Button {
                Task {
                    guard let fileUrl = Bundle.main.url(forResource: key, withExtension: ".mp3") else { return }
                    self.url = URL.MP3(url: fileUrl)
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
                    try? await service.delete(key: key, ext: URL.MP3.fileExtension)
                }
            } label: {
                Text("Delete from FileManager")
            }
        }
        .font(.headline)
    }
}

struct FMMP3View_Previews: PreviewProvider {
    static var previews: some View {
        FMMP3View()
    }
}
