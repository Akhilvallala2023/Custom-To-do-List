//
//  TaskViewModelTests.swift
//  To do list
//
//  Created by Akhil Vallala on 6/1/25.
//

import XCTest
@testable import To_do_list

final class TaskViewModelTests: XCTestCase {

    var viewModel: TaskViewModel!

    override func setUpWithError() throws {
        viewModel = TaskViewModel()
    }

    func testAddTask() {
        let initialCount = viewModel.tasks.count
        viewModel.addTask("Test Task")
        XCTAssertEqual(viewModel.tasks.count, initialCount + 1)
        XCTAssertEqual(viewModel.tasks.last?.title, "Test Task")
    }

    func testToggleComplete() {
        viewModel.addTask("Test Toggle")
        guard let task = viewModel.tasks.first else {
            XCTFail("No task found")
            return
        }

        viewModel.toggleComplete(task)
        XCTAssertTrue(viewModel.tasks[0].isCompleted)
    }

    func testDeleteTask() {
        viewModel.addTask("To Delete")
        let initialCount = viewModel.tasks.count
        viewModel.deleteTask(at: IndexSet(integer: 0))
        XCTAssertEqual(viewModel.tasks.count, initialCount - 1)
    }
}
