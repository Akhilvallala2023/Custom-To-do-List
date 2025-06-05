import SwiftUI

struct TaskListView: View {
    @StateObject private var viewModel = TaskViewModel()
    @State private var showingAddTask = false
    @State private var selectedTask: TaskItem? = nil
    @State private var taskStartTime: Date? = nil
    @State private var currentTime = Date()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
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

                // ✅ Scrollable Task List
                List {
                    Section(header: Text("To-Do")) {
                        ForEach(viewModel.todoTasks) { task in
                            VStack(alignment: .leading, spacing: 8) {
                                TaskRowView(
                                    task: task,
                                    viewModel: viewModel,
                                    isTiming: selectedTask?.id == task.id,
                                    elapsedTime: selectedTask?.id == task.id && taskStartTime != nil
                                        ? Int(currentTime.timeIntervalSince(taskStartTime!))
                                        : nil
                                )

                                HStack {
                                    Spacer()
                                    if selectedTask?.id == task.id {
                                        Button("Stop") {
                                            if let start = taskStartTime {
                                                let duration = Date().timeIntervalSince(start)
                                                viewModel.completeTask(task, duration: duration)
                                            }
                                            selectedTask = nil
                                            taskStartTime = nil
                                        }
                                        .buttonStyle(.borderedProminent)
                                        .tint(.red)
                                    } else {
                                        Button("Start") {
                                            selectedTask = task
                                            taskStartTime = Date()
                                        }
                                        .buttonStyle(.bordered)
                                        .tint(.blue)
                                    }
                                }
                            }
                            .padding(.vertical, 4)
                        }
                        .onDelete(perform: viewModel.deleteTask)
                    }

                    Section(header: Text("Completed")) {
                        ForEach(viewModel.completedTasks) { task in
                            TaskRowView(
                                task: task,
                                viewModel: viewModel,
                                isTiming: selectedTask?.id == task.id,
                                elapsedTime: selectedTask?.id == task.id && taskStartTime != nil
                                    ? Int(currentTime.timeIntervalSince(taskStartTime!))
                                    : nil
                            )
                        }
                        .onDelete(perform: viewModel.deleteTask)
                    }
                }
                .listStyle(.plain)
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
            .onReceive(timer) { time in
                currentTime = time
            }
            }
        }
    }


#Preview {
    TaskListView()
}

