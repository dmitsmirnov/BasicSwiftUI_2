//
//  AddTaskView.swift
//  BaseProject
//
//  Created by user on 19.08.2024.
//

import SwiftUI

struct AddTaskView: View {
    @EnvironmentObject var taskList: TaskList
    @State private var newTaskTitle: String = ""
    
    var body: some View {
        VStack {
                TextField("Enter name task", text: $newTaskTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button(action: {
                taskList.addTask(title: newTaskTitle)
                newTaskTitle = ""
            }) {
                Text("Add new task")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(5)
            }
        }
    }
}

#Preview {
    AddTaskView()
}
