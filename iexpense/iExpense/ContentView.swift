//
// iExpense
//

import SwiftUI
import Observation

struct ContentView: View {

    @State private var user = User()
    @State private var isSheetVisible = false

    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName).")
            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
            Button("Show sheet") {
                isSheetVisible.toggle()
            }.buttonStyle(.bordered)
        } // VStack
        .padding()
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

    var body: some View {
        Text("Hello \(name)")
        Text("Second view")
    }

}

#Preview {
    ContentView()
}
