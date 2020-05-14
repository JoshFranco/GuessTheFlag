//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Josh Franco on 5/7/20.
//  Copyright © 2020 Josh Franco. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany",
                                    "Ireland", "Italy", "Nigeria",
                                    "Poland", "Russia", "Spain",
                                    "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var currentScore = 0
    @State private var flagAniDegrees: [Double] =  Array(repeating: 0, count: 3)
    @State private var flagOpacitys: [Double] =  Array(repeating: 1, count: 3)
    @State private var wrongAttemtps = Array(repeating: 0, count: 3)
    
    // MARK: - Body
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0..<3) { btnIndex in
                    Button(action: {
                        self.flagTapped(at: btnIndex)
                        
                    }) {
                        Image(self.countries[btnIndex])
                            .renderingMode(.original)
                            .flatImageStyle()
                    }
                    .shake(for: self.wrongAttemtps[btnIndex])
                    .opacity(self.flagOpacitys[btnIndex])
                    .rotation3DEffect(.degrees(self.flagAniDegrees[btnIndex]),
                                      axis: (x: 0, y: 1, z: 0))
                }
                
                Text("Your current score is \(self.currentScore)")
                    .foregroundColor(.white)
                    .font(.callout)
                    .fontWeight(.semibold)
                
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle),
                  message: Text("Your score is \(self.currentScore)"),
                  dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                })
        }
    }
}

// MARK: - Private Methods
private extension ContentView {
    func flagTapped(at index: Int) {
        if index == correctAnswer {
            scoreTitle = "Correct"
            currentScore += 1
            
            withAnimation {
                flagAniDegrees[index] += 360

                for opacityIndex in 0..<flagOpacitys.count {
                    guard opacityIndex != index else { continue }
                    
                    flagOpacitys[opacityIndex] = 0.25
                }
            }
        } else {
            scoreTitle = "Wrong :( \n Thats the flag for \(countries[index])"
            
            withAnimation{
                self.wrongAttemtps[index] += 1
            }
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        self.countries.shuffle()
        self.correctAnswer = Int.random(in: 0...2)
        for index in 0..<flagOpacitys.count {
            flagOpacitys[index] = 1
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
