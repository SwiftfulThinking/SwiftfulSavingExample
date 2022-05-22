//
//  ContentView.swift
//  SwiftfulSavingExample
//
//  Created by Nick Sarno on 5/2/22.
//

import SwiftUI
import SwiftfulSaving


struct ContentView: View {
        
    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink {
                        FMImageView()
                    } label: {
                        Text("UIImage")
                    }
                    NavigationLink {
                        FMCodableView()
                    } label: {
                        Text("Codable")
                    }
                    NavigationLink {
                        FMMP3View()
                    } label: {
                        Text("MP3")
                    }
                    NavigationLink {
                        FMMP4View()
                    } label: {
                        Text("MP4")
                    }
                    NavigationLink {
                        FMImageStreamableView()
                    } label: {
                        Text("UIImage Streamable")
                    }
                } header: {
                    Text("File Manager")
                }
                
                Section {
                    NavigationLink {
                        CDExampleView()
                    } label: {
                        Text("Item / Entity")
                    }
                } header: {
                    Text("Core Data")
                }
                
                Section {
                    NavigationLink {
                        UDExampleView()
                    } label: {
                        Text("String")
                    }
                } header: {
                    Text("User Defaults")
                }
            }
            .navigationTitle("Saving stuff 🤓")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
