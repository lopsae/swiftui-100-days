//
// RockPaperScissors
//


import SwiftUI


struct ContentView: View {

    var body: some View {
        VStack {
            Text("The computer has chosen")
            Text("🪨")
                .font(.largeTitle)
                .padding()
                .background(.blue.gradient)
                .clipShape(.circle)
        } .padding() // VStack

        VStack {
            Text("Your choice:")
            HStack {
                Button(action: {}, label: {
                    Text("🪨")
                        .font(.largeTitle)
                }).buttonStyle(.bordered)
                Button(action: {}, label: {
                    Text("📄")
                        .font(.largeTitle)
                }).buttonStyle(.bordered)
                Button(action: {}, label: {
                    Text("✂️")
                        .font(.largeTitle)
                }).buttonStyle(.bordered)
            } // HStack
        } .padding() // VStack

        VStack {
            Text("Score")
            Text("Won: TODO")
            Text("Attempts: TODO")
        }.padding() // VStack
    } // body

}

#Preview {
    ContentView()
}
