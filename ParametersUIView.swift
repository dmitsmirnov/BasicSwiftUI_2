//
//  ParametersUIView.swift
//  BaseProject
//
//  Created by user on 23.08.2024.
//

import SwiftUI

struct ParametersUIView: View {
    
    @State var total = 0
    
    var body: some View {
        
        VStack {
            
            Example(total: $total)
           
            Button {
                self.total = 200
            } label: {
                Text("Tach me")
            }

            
        }
    }
}

struct Example: View {
    
    @Binding var total: Int
    
    var body: some View {
        Text(String(total))
    }
}

#Preview {
    ParametersUIView()
}
