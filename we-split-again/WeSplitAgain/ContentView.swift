//
//  ContentView.swift
//  WeSplitAgain
//
//  Created by Maic Lopez Saenz on 10/27/23.
//

import SwiftUI

struct ContentView: View {

    let tipOptions = [0, 10, 15, 20, 25]

    @State private var tapCount = 0
    @State private var name = ""

    static let students = ["Andy", "Betty", "Calisto"]
    @State private var selectedStudent = students[1]

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Enter your name", text: $name)
                    Text("Entered name: \(name)")
                }
                Section {
                    Picker("Select your student", selection: $selectedStudent) {
                        ForEach(Self.students, id: \.self) {
                            Text("Sophmore: \($0)")
                        }
                    }
                }
                Section {
                    ForEach(0..<3) { item in
                        Text("Row \(item)")
                    }
                }
                // Outside section
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
