//
// RockPaperScissors
//


enum Hand: String, CaseIterable {

    case rock
    case paper
    case scissor

    var emoji: String {
        switch self {
        case .rock:    return "🪨"
        case .paper:   return "📄"
        case .scissor: return "✂️"
        }
    }


    var beats: Self {
        switch self {
        case .rock:    return .scissor
        case .paper:   return .rock
        case .scissor: return .paper
        }
    }


    func beats(_ hand: Self) -> Bool {
        return self.beats == hand
    }
}

