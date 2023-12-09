//
// iExpense
//

import SwiftUI
import Observation

struct ContentView: View {

    @State private var user = User(firstName: "Sphinx", lastName: "Quartz")
    @State private var isSheetVisible = false

    @AppStorage("tapCounter") private var tapCounter = 0

    @State private var numbers: [Int] = [1, 2, 3]
    @State private var nextNumber = 4

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text("Your name is \(user.firstName) \(user.lastName).")
                    TextField("First name", text: $user.firstName)
                    TextField("Last name", text: $user.lastName)
                    Button("Show sheet") {
                        isSheetVisible.toggle()
                    }.buttonStyle(.bordered)
                    .frame(maxWidth: .infinity)
                    Button("Store user") {
                        let encoder = JSONEncoder()
                        if let data = try? encoder.encode(user) {
                            UserDefaults.standard.set(data, forKey: "UserObject")
                            print("User saved")
                        }
                    }.buttonStyle(.bordered)
                    .frame(maxWidth: .infinity)
                    Button("Load user") {
                        let decoder = JSONDecoder()
                        if let data = UserDefaults.standard.data(forKey: "UserObject"),
                           let decoded = try? decoder.decode(User.self, from: data)
                        {
                            user = decoded
                            print("User loaded")
                        }
                    }.buttonStyle(.bordered)
                    .frame(maxWidth: .infinity)
                } // Section

                Section {
                    Button("Tap count: \(tapCounter)") {
                        tapCounter += 1
                    }.buttonStyle(.bordered)
                    .frame(maxWidth: .infinity)
                } // Section

                Section {
                    List {
                        ForEach(numbers, id: \.self) {
                            Text("Row: \($0)")
                        }
                        .onDelete(perform: removeRows(at:))
                    }
                    Button("Add number") {
                        numbers.append(nextNumber)
                        nextNumber += 1
                    }.buttonStyle(.bordered)
                        .frame(maxWidth: .infinity)
                } // Section
            } // Form
            .navigationTitle("Form")
            .toolbar {
                EditButton()
            }
            .sheet(isPresented: $isSheetVisible) {
                SecondView(name: user.firstName)
            }
        } // NavigationStack
    } // body


    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}


struct User: Codable {

    var firstName: String
    var lastName: String

}


struct SecondView: View {

    let name: String
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Text("Hello \(name)")
        Text("Second view")
        Button("Dismiss") {
            dismiss()
        }.buttonStyle(.bordered)
    }

}

#Preview {
    ContentView()
}
