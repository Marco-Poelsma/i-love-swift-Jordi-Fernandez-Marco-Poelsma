//
//  ContentView.swift
//  Game
//
//  Created by alumne on 27/10/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var alertVisible = false
    @State var sliderValue = 50.0
    var body: some View {
        VStack(spacing: 5) {
            Color("BackgroundColor").ignoresSafeArea()
            //VStack()
            Text("🙈🙉🙊")
                .font(.largeTitle)
            Text("80")
                .font(.largeTitle)
                .fontWeight(.bold)
                .kerning(-1)
            SliderView(value: $sliderValue, lowValue: 1,highValue: 100)
            Text("Slider value tracking \(sliderValue)")
            Button("TRY") {
                alertVisible = true
            }
            .padding()
            .font(.title)
            .background(Color.red)
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

struct SliderView: View {
    @Binding var value:Double
    let lowValue:Double
    let highValue:Double
    var body: some View {
        HStack {
            Text("\(Int(lowValue))").fontWeight(.bold)
            Slider(value: $value, in: lowValue...highValue)
            Text("\(Int(highValue))").fontWeight(.bold)
        }
        .padding(.horizontal)
    }
}
