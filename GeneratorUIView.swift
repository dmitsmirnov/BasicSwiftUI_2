//
//  GeneratorUIView.swift
//  BaseProject
//
//  Created by user on 15.08.2024.
//

import SwiftUI

struct GeneratorUIView: View {
    
    @State private var buttonPressed = false
    
    var body: some View {
        
        VStack {
     
            Button(action: {
                
                withAnimation {
                    self.buttonPressed.toggle()
                    
                    if self.buttonPressed {
                        let generator = UINotificationFeedbackGenerator()
                        generator.notificationOccurred(.success) // Можно использовать .error, .warning и другие
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation {
                            self.buttonPressed.toggle()
                        }
                    }
                    
                }
                
            }, label: {
                
                Text("Вибрация")
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15)
                        .fill(Color.yellow)
                        .shadow(color: .black, radius: 5, x: 0, y: 2)
                        .frame(width: 200, height: 50))
                    .padding()
                    .scaleEffect(buttonPressed ? 0.9 : 1.0)
                    .animation(.spring())
                
            }
            )
            
            Button("Длинная вибрация") {
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 15)
                .fill(Color.yellow)
                .shadow(color: .black, radius: 5, x: 0, y: 2)
                .frame(width: 200, height: 50))
            .padding()
            
            Button("Выбор") {
                let generator = UISelectionFeedbackGenerator()
                generator.selectionChanged()
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 15)
                .fill(Color.yellow)
                .shadow(color: .black, radius: 5, x: 0, y: 2)
                .frame(width: 200, height: 50))
            .padding()
           
        }
        
        
    }
}

#Preview {
    GeneratorUIView()
}
