//
//  TaskDataSource.swift
//  TodoAppExample
//
//  Created by Nishihara Kiyoshi on 2018/10/04.
//  Copyright © 2018年 Nishihara Kiyoshi. All rights reserved.
//

import Foundation

class TaskDataSource: NSObject {
    
    private var tasks: [Task]!
    
    override init() {
        super.init()
        loadData()
    }
    
    func loadData() {
        let userDefaults = UserDefaults.standard
        let taskData = userDefaults.object(forKey: "tasks") as? Data
        guard let t = taskData else { return }
        let unArchiveData = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(t)
        tasks = unArchiveData as? [Task] ?? [Task]()
    }
    
    func save(task: Task) {
        tasks.append(task)
        let encodedTask = try? NSKeyedArchiver.archivedData(withRootObject: tasks, requiringSecureCoding: false)
        let userDefaults = UserDefaults.standard
        userDefaults.set(encodedTask, forKey: "tasks")
        userDefaults.synchronize()
    }
    
    func count() -> Int {
        return tasks.count
    }
    
    func data(at index: Int) -> Task? {
        if tasks.count > index {
            return tasks[index]
        }
        
        return nil
    }
}
