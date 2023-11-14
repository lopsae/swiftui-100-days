//
//  ContentView.swift
//  Animations
//
//  Created by Maic Lopez Saenz on 11/14/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "paintbrush.pointed")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Animations")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
