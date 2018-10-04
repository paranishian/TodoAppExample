//
//  CreateTaskViewController.swift
//  TodoAppExample
//
//  Created by Nishihara Kiyoshi on 2018/10/04.
//  Copyright © 2018年 Nishihara Kiyoshi. All rights reserved.
//

import UIKit

class CreateTaskViewController: UIViewController {
    
    private var createTaskView: CreateTaskView!
    private var dataSource: TaskDataSource!
    private var taskText: String?
    private var taskDeadline: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        createTaskView = CreateTaskView()
        createTaskView.delegate = self
        view.addSubview(createTaskView)
        
        dataSource = TaskDataSource()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        createTaskView.frame = CGRect(x: view.safeAreaInsets.left,
                                      y: view.safeAreaInsets.top,
                                      width: view.frame.size.width - view.safeAreaInsets.left - view.safeAreaInsets.right,
                                      height: view.frame.size.height - view.safeAreaInsets.bottom)
    }
    
    // 保存が成功したときのアラート
    private func showSaveAlert() {
        let alertController = UIAlertController(title: "保存しました",
                                                message: nil,
                                                preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel) { (action) in
            _ = self.navigationController?.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    // タスクが未入力のときのアラート
    private func showMissingTaskTextAlert() {
        let alertController = UIAlertController(title: "タスクを入力してください",
                                                message: nil,
                                                preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    // 締切日が未入力のときのアラート
    private func showMissingTaskDeadlineAlert() {
        let alertController = UIAlertController(title: "締切日を入力してください",
                                                message: nil,
                                                preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}

extension CreateTaskViewController: CreateTaskViewDelegate {
    // タスク内容を入力しているときに呼ばれるデリゲートメソッド
    // CreateTaskViewからタスク内容を受け取り、taskTextに代入している
    func createView(taskEditing view: CreateTaskView, text: String) {
        taskText = text
    }
    
    // 締切日時を入力しているときに呼ばれるデリゲートメソッド
    // CreateTaskViewから締切日時を受け取り、taskDeadlineに代入している
    func createView(dealineEditting view: CreateTaskView, deadline: Date) {
        taskDeadline = deadline
    }
    
    // 保存ボタンが押されたときに呼ばれるデリゲートメソッド
    func createView(saveButtonDidTap view: CreateTaskView) {
        guard let taskText = taskText else {
            showMissingTaskTextAlert()
            return
        }
        guard let taskDeadline = taskDeadline else {
            showMissingTaskDeadlineAlert()
            return
        }
        let task = Task(text: taskText, deadline: taskDeadline)
        dataSource.save(task: task)
        
        showSaveAlert()
    }
}
