//
//  ScrollReaderUIView.swift
//  BaseProject
//
//  Created by user on 02.09.2024.
//

import SwiftUI

struct ScrollReaderUIView: View {
    
    var body: some View {
        ScrollViewReader { proxy in
            VStack {
                Button("Jump to #50") {
                    
                    withAnimation {
                        proxy.scrollTo(50, anchor: .top)
                    }
                    
                }
                
                List(0..<100, id: \.self) { i in
                    Text("Example \(i)")
                        .id(i)
                }
            }
            .onAppear {
                withAnimation {
                    proxy.scrollTo(50, anchor: .top)
                }
            }
        }
    }
}

#Preview {
    ScrollReaderUIView()
}
