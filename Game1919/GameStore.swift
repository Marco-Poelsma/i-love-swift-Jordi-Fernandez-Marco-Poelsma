import Foundation

class GameStore: ObservableObject {
    @Published var game = Game()
    
    @Published var totalScore = 0
    @Published var gamesPlayed = 0
    @Published var isGameOver = false
    
    @Published var highScores: [Int] = []
    
    func calculatePoints(value: Double) {
        game.calculatePoints(sliderValue: value)
        
        totalScore += game.points
        gamesPlayed += 1
        
        // Como solo tiene 1 vida, si la diferencia es grande → fin de partida
        if game.points < 50 {  // ejemplo: fallo grande = <50
            endGame()
        }
    }
    
    func restart() {
        game.restart()
        isGameOver = false
    }
    
    func resetAll() {
        totalScore = 0
        gamesPlayed = 0
        game = Game()
        isGameOver = false
    }
    
    func endGame() {
        isGameOver = true
        highScores.append(totalScore)
        highScores.sort(by: >)
        highScores = Array(highScores.prefix(5)) // solo top 5
    }
}
