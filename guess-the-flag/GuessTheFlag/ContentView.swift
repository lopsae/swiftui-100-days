//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Maic Lopez Saenz on 10/31/23.
//

import SwiftUI

struct ContentView: View {

    @State private var showingAlert = false

    var body: some View {
        ZStack {
//            VStack(spacing: 0) {
//                Color.red
//                Color.blue
//            }
//            LinearGradient(
//                stops: [
//                    .init(color: .white, location: 0.4),
//                    .init(color: .red, location: 0.5)],
//                startPoint: .top, endPoint: .trailing)
//            RadialGradient(
//                colors: [.white, .red],
//                center: .top, startRadius: 20, endRadius: 200)
            AngularGradient(colors: [.white, .red, .white], center: .center)

            VStack {
                Text("With some color")
                    .padding(50)
//                    .foregroundStyle(.secondary)
//                    .background(.ultraThinMaterial)
                    .foregroundStyle(.white)
                    .background(.red.gradient)
                Button {
                    showingAlert = true
                } label: {
                    Label("Show Alert", systemImage: "pencil")
//                    Image(systemName: "pencil")
//                    Text("Tap me!")
                }
                .alert("Important Message", isPresented: $showingAlert) {
                    Button("OK") {}
                    Button("One") {}
                    Button("Two") {}
                    Button("CNCL", role: .cancel) {}
                    Button("Many", role: .destructive) {}
                } message: {
                    Text("This is the alert message.")
                }
//                .buttonStyle(.borderedProminent)
//                    .tint(.mint)
            }

        }.ignoresSafeArea()

    }
}

#Preview {
    ContentView()
}
