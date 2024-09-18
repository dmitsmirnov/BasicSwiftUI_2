//
//  EnvironmentObjectUIView.swift
//  BaseProject
//
//  Created by user on 19.08.2024.
//

import SwiftUI

class Task: Identifiable {
    let id = UUID()
    var title: String
    
    init(title: String) {
        self.title = title
    }
}

class TaskList: ObservableObject {
    
    @Published var tasks: [Task] = []
    
    func addTask(title: String) {
        let newTask = Task(title: title)
        tasks.append(newTask)
    }
}


struct EnvironmentObjectUIView: View {
    
    @StateObject private var taskList = TaskList()
     
    var body: some View {
        
        NavigationView {
            VStack {
                AddTaskView()
                    .environmentObject(taskList)
                TaskListView()
                    .environmentObject(taskList)
            }
            .navigationTitle("Tasks")
        }
        
        
    }
}

#Preview {
    EnvironmentObjectUIView()
    //AddTaskView()
}
