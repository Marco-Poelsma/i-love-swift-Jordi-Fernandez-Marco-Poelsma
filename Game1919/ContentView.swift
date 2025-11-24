import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var gameStore: GameStore
    
    @State private var alertVisible = false
    @State private var sliderValue = (Game.highNumber-Game.lowNumber)/2
    @State private var showScoreboard = false
    
    var body: some View {
        ZStack() {
            Color("BackgroundColor").ignoresSafeArea()
            
            VStack {
                
                // MARK: - BARRA SUPERIOR
                HStack {
                    Button("🔄 Reset") {
                        gameStore.resetAll()
                        sliderValue = (Game.highNumber - Game.lowNumber) / 2
                    }
                    
                    Spacer()
                    
                    Button("🏆 Scores") {
                        showScoreboard = true
                    }
                }
                .padding(.horizontal)
                
                // MARK: - TÍTULO
                Text("🙈🙉🙊")
                    .font(.largeTitle)
                
                // MARK: - NÚMERO A ADIVINAR
                Text("\(gameStore.game.guessNumber)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .kerning(-1)
                
                // MARK: - SLIDER
                SliderView(
                    value: $sliderValue,
                    lowValue: Game.lowNumber,
                    highValue: Game.highNumber
                )
                
                Text("Slider value tracking \(sliderValue)")
                
                // MARK: - BOTÓN TRY
                Button("TRY") {
                    gameStore.calculatePoints(value: sliderValue)
                    alertVisible = true
                }
                .padding()
                .font(.title)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(21.0)
                .disabled(gameStore.isGameOver)
                
                // MARK: - INFO DEL JUGADOR
                VStack(spacing: 8) {
                    Text("Score total: \(gameStore.totalScore)")
                    Text("Partidas jugadas: \(gameStore.gamesPlayed)")
                }
                .padding(.top)
            }
            .padding()
            
        }
        
        // MARK: - ALERTAS
        .alert(isPresented: $alertVisible) {
            
            if gameStore.isGameOver {
                return Alert(
                    title: Text("Game Over 💀"),
                    message: Text("Tu score total fue \(gameStore.totalScore)"),
                    dismissButton: .default(Text("OK")) {}
                )
            } else {
                return Alert(
                    title: Text("Buen tiro!"),
                    message: Text("Puntos obtenidos: \(gameStore.game.points)"),
                    dismissButton: .default(Text("OK")) {
                        gameStore.restart()
                        sliderValue = (Game.highNumber - Game.lowNumber)/2
                    }
                )
            }
        }
        
        // MARK: - SCOREBOARD
        .sheet(isPresented: $showScoreboard) {
            ScoreboardView(showScoreboard: $showScoreboard)
                .environmentObject(gameStore)
        }

    }
}

struct SliderView: View {
    @Binding var value: Double
    let lowValue: Double
    let highValue: Double
    
    var body: some View {
        HStack {
            Text("\(Int(lowValue))")
                .fontWeight(.bold)
            
            Slider(value: $value, in: lowValue...highValue)
                .padding(.horizontal)
            
            Text("\(Int(highValue))")
                .fontWeight(.bold)
        }
        .padding(.horizontal)
    }
}
