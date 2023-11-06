//
//  ContentView.swift
//  BetterRest
//
//  Created by Maic Lopez Saenz on 11/6/23.
//

import SwiftUI

struct ContentView: View {

    @State private var sleepAmount = 8.0

    var body: some View {
        Form {
            Stepper("\(sleepAmount.formatted()) Hours", value: $sleepAmount, in: 4...12, step: 0.25)
        }
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Better Rest")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
