import SwiftUI

struct ScoreboardView: View {
    @EnvironmentObject var gameStore: GameStore
    @Binding var showScoreboard: Bool

    var body: some View {
        VStack {
            Text("🏆 Top 5 Scores")
                .font(.largeTitle)
                .padding()

            List {
                ForEach(0..<gameStore.highScores.count, id: \.self) { i in
                    Text("• \(gameStore.highScores[i]) points")
                }
            }

            Button("Close") {
                showScoreboard = false
            }
            .padding()
        }
    }
}
