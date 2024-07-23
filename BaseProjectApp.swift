//
//  BaseProjectApp.swift
//  BaseProject
//
//  Created by dmitsmirnov on 18.03.2024.
//

import SwiftUI
import TipKit

@main
struct BaseProjectApp: App {
    var body: some Scene {
        WindowGroup {
            //Picker_VMPUIView()
            TipKitUIView()
                .task {
                    
                    try? Tips.resetDatastore()
                    
                    try? Tips.configure([
                        .displayFrequency(.immediate),
                        .datastoreLocation(.applicationDefault)])
                }
        }
        
    }
}
