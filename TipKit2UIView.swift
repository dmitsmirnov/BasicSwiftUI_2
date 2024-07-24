import SwiftUI
import TipKit

struct FirstTip: Tip {
    var title: Text {
        Text("This is the first tip.")
    }
    
    var message: Text? {
        Text("This is the first tip's body.")
    }
}

struct SecondTip: Tip {
    var title: Text {
        Text("This is the second tip.")
    }
    
    var message: Text? {
        Text("This is the second tip's body.")
    }
}

struct ThirdTip: Tip {
    var title: Text {
        Text("This is the third tip.")
    }
    
    var message: Text? {
        Text("This is the third tip's body.")
    }
}

struct TipKit2UIView: View {
    // The first tip shouldn't have an @State variable, because it'll show by default.
    @State var showSecondTip = false
    @State var showThirdTip = false
    
    let firstTip = FirstTip()
    let secondTip = SecondTip()
    let thirdTip = ThirdTip()
    
    var body: some View {
        VStack {
            TipView(firstTip)
                .onDisappear {
                    showSecondTip = true
                }
            
            Text("What do you call a factory that only makes mediocre products? A satisfactory.")
                .padding(.bottom)
            
            HStack {
                Button("That was not funny.") {
                    
                }.popover(isPresented: $showSecondTip) {
                    TipView(secondTip)
                        .onDisappear {
                            showThirdTip = true
                        }
                }
                
                Spacer()
                
                Button ("That was funny.") {
                    
                }
                .popover(isPresented: $showThirdTip) {
                    TipView(thirdTip)
                        .onDisappear {
                            // show further tips...
                        }
                }
            }
        }.padding()
    }
}

#Preview {
    TipKit2UIView()
        .task {
            try? Tips.resetDatastore()
            
            try? Tips.configure([
                .displayFrequency(.immediate),
                .datastoreLocation(.applicationDefault)
            ])
        }
}
