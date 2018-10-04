//
//  Task.swift
//  TodoAppExample
//
//  Created by Nishihara Kiyoshi on 2018/10/04.
//  Copyright © 2018年 Nishihara Kiyoshi. All rights reserved.
//

import Foundation

class Task: NSObject, NSCoding {
    
    let text: String
    let deadline: Date
    
    init(text: String, deadline: Date) {
        self.text = text
        self.deadline = deadline
    }
    
    init(from dictionary: [String: Any]) {
        self.text = dictionary["text"] as! String
        self.deadline = dictionary["deadline"] as! Date
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "text")
        aCoder.encode(deadline, forKey: "deadline")
    }
    
    required init?(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObject(forKey: "text") as! String
        deadline = aDecoder.decodeObject(forKey: "deadline") as! Date
    }
}
