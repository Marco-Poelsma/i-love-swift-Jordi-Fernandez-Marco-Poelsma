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
                
                // MARK: - TOP BAR (Reset izquierda, Scores derecha)
                HStack {
                    Button("🔄 Reset") {
                        gameStore.resetAll()
                        sliderValue = (Game.highNumber - Game.lowNumber) / 2
                    }
                    .padding(.leading)
                    
                    Spacer()
                    
                    Button("🏆 Scores") {
                        showScoreboard = true
                    }
                    .padding(.trailing)
                }
                .padding(.top)
                
                
                Spacer()    // Empuja el contenido hacia abajo
                
                
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
                
                Text("Slider value tracking \(Int(sliderValue))")
                
                
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
                
                
                Spacer()    // Empuja score y partidas hacia abajo
                
                
                // MARK: - BOTTOM INFO (Score y Partidas)
                VStack(spacing: 8) {
                    Text("Score total: \(gameStore.totalScore)")
                        .font(.title2)
                    Text("Partidas jugadas: \(gameStore.gamesPlayed)")
                        .font(.title2)
                }
                .padding(.bottom, 30)
            }
            .padding(.horizontal)
        }
        
        
        // MARK: - ALERTAS
        .alert(isPresented: $alertVisible) {
            
            if gameStore.isGameOver {
                return Alert(
                    title: Text("Game Over 💀"),
                    message: Text("Tu score total fue \(gameStore.totalScore)"),
                    dismissButton: .default(Text("OK"))
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
                .accentColor(.green) // Funciona en iOS 13+
                .padding(.horizontal)
            
            Text("\(Int(highValue))")
                .fontWeight(.bold)
        }
        .padding(.horizontal)
    }
}
