//
//  TaskListView.swift
//  BaseProject
//
//  Created by user on 19.08.2024.
//

import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var taskList: TaskList
    var body: some View {
        List(taskList.tasks) { task in
            Text(task.title)
        }
    }
}

#Preview {
    TaskListView()
}
