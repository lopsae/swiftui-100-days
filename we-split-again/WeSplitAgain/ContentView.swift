//
//  ContentView.swift
//  WeSplitAgain
//
//  Created by Maic Lopez Saenz on 10/27/23.
//

import SwiftUI

struct ContentView: View {

    @State private var tapCount = 0
    @State private var name = ""

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Enter your name", text: $name)
                    Text("Entered name: \(name)")
                }
                Section {
                    Text("Second text")
                    Text("Third text")
                }
                Button("Tap Count: \(tapCount)") {
                    tapCount += 1
                }
            }
            .navigationTitle("Title")
            .navigationBarTitleDisplayMode(.inline)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
