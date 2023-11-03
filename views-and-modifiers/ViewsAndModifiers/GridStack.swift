//
// ViewsAndModifiers
//


import SwiftUI


struct GridStack<Content: View>: View {

    let rows: Int
    let columns: Int
    @ViewBuilder let content: (Int, Int) -> Content // (row, column)

    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { rowIndex in
                HStack {
                    ForEach(0..<columns, id: \.self) { columnIndex in
                        content(rowIndex, columnIndex)
                    }
                } // HStack
            }
        } // VStack
    }

}
