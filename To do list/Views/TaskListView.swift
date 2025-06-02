import SwiftUI

struct TaskListView: View {
    @StateObject private var viewModel = TaskViewModel()
    @State private var showingAddTask = false

    var body: some View {
        NavigationView {
            VStack {
                // ✅ XP, Level, and Progress Bar
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("XP: \(viewModel.xp)")
                            .font(.headline)
                        Spacer()
                        Text("Level: \(viewModel.level)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }

                    // ✅ Progress Bar toward next level
                    ProgressView(
                        value: Double(viewModel.xp - viewModel.xpAtCurrentLevelStart),
                        total: Double(viewModel.xpForNextLevel - viewModel.xpAtCurrentLevelStart)
                    )
                    .accentColor(.green)
                    .scaleEffect(x: 1, y: 2, anchor: .center)



                }
                .padding(.horizontal)

                // ✅ Task List
                List {
                    ForEach(viewModel.tasks) { task in
                        TaskRowView(task: task, viewModel: viewModel)
                    }
                    .onDelete(perform: viewModel.deleteTask)
                }
            }
            .navigationTitle("To-Do List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddTask = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddTask) {
                AddTaskView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    TaskListView()
}

