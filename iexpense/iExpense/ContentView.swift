//
// iExpense
//

import SwiftUI
import Observation

struct ContentView: View {

    @State private var user = User()
    @State private var isSheetVisible = false

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
            .onAppear {
                let oneUser = User()
                let otherUser = oneUser
                otherUser.lastName = "Malachite"

                print("One: \(oneUser)")
                print("Other: \(otherUser)")
            }
        } // NavigationStack
    } // body


    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}


@Observable class User: CustomStringConvertible {

    var firstName: String = "Black"
    var lastName: String = "Quartz"

    var description: String {
        "User firstName:\(firstName) lastName:\(lastName)"
    }

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
