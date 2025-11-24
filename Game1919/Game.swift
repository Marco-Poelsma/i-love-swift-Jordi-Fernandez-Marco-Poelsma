import Foundation

struct Game {
    static let lowNumber: Double = 1
    static let highNumber: Double = 100
    
    var guessNumber = Int.random(in: Int(lowNumber)...Int(highNumber))
    var points = 0
    
    mutating func calculatePoints(sliderValue: Double) {
        let difference = abs(guessNumber - Int(sliderValue.rounded()))
        self.points = Int(Game.highNumber) - difference
    }
    
    mutating func restart() {
        guessNumber = Int.random(in: Int(Game.lowNumber)...Int(Game.highNumber))
    }
}
