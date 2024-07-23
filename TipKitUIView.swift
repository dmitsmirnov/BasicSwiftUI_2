//
//  TipKitUIView.swift
//  BaseProject
//
//  Created by user on 23.07.2024.
//

import SwiftUI
import TipKit

struct TipKitUIView: View {
    
    @State private var colors = MockData.colors
    
    let addColorTip = AddColorTip()
    let setFavoriteTip = SetFavoriteTip()
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
            
                TipView(setFavoriteTip)
                    .tipBackground(.teal.opacity(0.2))
                
                ForEach(colors, id: \.self) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill($0.gradient)
                        .frame(height: 100)
                        .contextMenu {
                            Button("Favorite", systemImage: "star") {
                                
                            }
                        }
                }
                
            }
            .padding()
            .navigationTitle("Colors")
            .toolbar {
                Button {
                    colors.insert(.random, at: 0)
                    //
                    addColorTip.invalidate(reason: .actionPerformed)
                } label : {
                    Image(systemName: "plus")
                }
                .popoverTip(addColorTip)
            }
            
        }
        
    }
}

#Preview {
    TipKitUIView()
        .task {
            
            try? Tips.resetDatastore()
            
            try? Tips.configure([
                .displayFrequency(.immediate),
                .datastoreLocation(.applicationDefault)])
        }
}

extension Color {
    static var random: Color {
        return Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
    }
}

struct MockData {
    static let colors = [Color.random, Color.random, Color.random, Color.random]
}

struct AddColorTip: Tip {
    var title: Text {
        Text("Add new color")
            .foregroundStyle(.teal)
    }
    var message: Text? {
        Text("Tap here to add a new color to the list")
    }
    var image: Image? {
        Image(systemName: "paintpalette")
    }
}

struct SetFavoriteTip: Tip {
    var title: Text {
        Text("Set favorite")
    }
    var message: Text? {
        Text("Tap and hold a color to add it to your favorites")
    }

}
