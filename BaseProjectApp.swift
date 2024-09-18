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
    
    @StateObject private var taskList = TaskList()
    
    var body: some Scene {
        WindowGroup {
            //Picker_VMPUIView()
//            TipKitUIView()
//                .task {
//                    
//                    try? Tips.resetDatastore()
//                    
//                    try? Tips.configure([
//                        .displayFrequency(.immediate),
//                        .datastoreLocation(.applicationDefault)])
//                }
//            EnvironmentObjectUIView()
//                .environmentObject(taskList)
            SearchUIView()
        }
        
    }
}
