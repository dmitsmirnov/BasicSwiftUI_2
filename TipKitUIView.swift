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
    let infoTip = InfoTip()
    
    var longPressGameTip = LongPressGameTip()
    
    @State var showInfo = false
    
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
               
                Spacer()
                
                Button {
                    LongPressGameTip.isLoggedIn = true
                } label: {
                    Image(systemName: "play.circle")
                }
                .popoverTip(longPressGameTip)
                .padding()
                
                Button {
                    //longPressGameTip.invalidate(reason: .actionPerformed)
                    //LongPressGameTip.isLoggedIn = false
                    longPressGameTip.invalidate(reason: .tipClosed)
                } label: {
                    Image(systemName: "play.circle")
                }
                
            }
            .padding()
            .navigationTitle("Colors")
            .toolbar {
                
                HStack {
                    
                    Button {
                        colors.insert(.random, at: 0)
                        //
                        addColorTip.invalidate(reason: .actionPerformed)
                    } label : {
                        Image(systemName: "plus")
                    }
                    //.popoverTip(addColorTip)
                    
//                    Button {
//                        //showInfo.toggle()
//                        //LongPressGameTip.isLoggedIn = true
//                        LongPressGameTip.isLoggedIn = true
//                        //longPressGameTip.invalidate(reason: .actionPerformed)
//                        
//                    } label: {
//                        Image(systemName: "play.circle")
//                    }
                    
                   
                    
                    //.popoverTip(longPressGameTip)
                    
                }
            }

        }
        //            .popoverTip(isPresented: $showInfo, content: InfoTip())
        //           .popoverTip(infoTip)
        //
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

struct InfoTip: Tip {
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
    
    var actions: [Action] {
        [Action(id: "learn-more", title: "Learn More", perform: {
            print("'Learn More' pressed")
        })]
    }
}

// parameter
struct LongPressGameTip: Tip {
    
    var title: Text {
        Text("Test")
    }
    
    var options: [TipOption] {
        [Tip.IgnoresDisplayFrequency(true), Tip.MaxDisplayCount(3)]
    }
    
    @Parameter
    static var isLoggedIn: Bool = false
    
    var rules: [Rule] {
        #Rule(Self.$isLoggedIn) { $0 == true }
    }
    
    // [...] заголовок, сообщение, актив, действия и т.д.
    
}

// event
struct LongPressGameTip_2: Tip {
    
    var title: Text
    
    static let appOpenedCount = Event(id: "appOpenedCount")
     
    //Если вы установили не мгновенную частоту отображения, но у вас есть подсказка, которую вы хотите отобразить немедленно, вы можете сделать это с помощью опции IgnoresDisplayFrequency
    
    // Если подсказка не отменена пользователем вручную, то она будет показана вновь при следующем появлении соответствующего представления даже после запуска приложения. Чтобы избежать повторного показа подсказки пользователю, можно задать значение MaxDisplayCount
    var options: [TipOption] {
        [Tip.IgnoresDisplayFrequency(false), Tip.MaxDisplayCount(3)]
    }
    
   
    var rules: [Rule] {
        #Rule(Self.appOpenedCount) { $0.donations.count >= 3 }
        
//        #Rule(Self.appOpenedCount) {
//            $0.donations.filter {
//                Calendar.current.isDateInToday($0.date)
//            }
//            .count >= 3
//        }
        
    }
    
    // [...] заголовок, сообщение, ассет, действия и т.д.
    
}

// debug
//Показать все определенные в приложении подсказки
//Tips.showAllTips()
//
// Показать указанные подсказки
//Tips.showTips([searchTip, longPressGameTip])
//
// Скрыть указанные подсказки
//Tips.hideTips([searchTip, longPressGameTip])
//
// Скрыть все подсказки, определенные в приложении
//Tips.hideAllTips()
