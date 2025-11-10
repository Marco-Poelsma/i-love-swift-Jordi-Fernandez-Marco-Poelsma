//
//  ContentView.swift
//  Game
//
//  Created by alumne on 27/10/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var alertVisible = false
    
    var body: some View {
        VStack(spacing: 5) {
            Text("🙈🙉🙊")
                .font(.largeTitle)
            Text("80")
            HStack {
                Text("1").fontWeight(.bold)
                Slider(value: .constant(50), in: 1...100)
                Text("100").fontWeight(.bold)
            }
            .padding(.horizontal)
            
            Button("TRY") {
                alertVisible = true
            }
            .padding()
            .font(.title)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(21.0)
            .alert(isPresented: $alertVisible) {
                Alert(
                    title: Text("Hello"),
                    message: Text("This is my first alert"),
                    dismissButton: .default(Text("Got it"))
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
