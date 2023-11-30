//
// iExpense
//


import Foundation


extension FormatStyle {

    static func localCurrencyOrUsd<Value>() -> Self
        where Self == FloatingPointFormatStyle<Value>.Currency,
              Value: BinaryFloatingPoint
    {
        let code = Locale.current.currency?.identifier ?? "USD"
        return .currency(code: code)
    }

}

