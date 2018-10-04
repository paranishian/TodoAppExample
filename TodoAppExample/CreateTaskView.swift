//
//  CreateTaskView.swift
//  TodoAppExample
//
//  Created by Nishihara Kiyoshi on 2018/10/04.
//  Copyright © 2018年 Nishihara Kiyoshi. All rights reserved.
//

import UIKit

// CreateTaskViewControllerへユーザインタラクションを伝達するためのProtocolです
protocol CreateTaskViewDelegate: class {
    func createView(taskEditing view: CreateTaskView, text: String)
    func createView(dealineEditting view: CreateTaskView, deadline: Date)
    func createView(saveButtonDidTap view: CreateTaskView)
}

class CreateTaskView: UIView {
    
    // タスク内容を入力するUITextField
    private var taskTextField: UITextField!
    // 締め切り時間を表示するUIPickerView
    private var datePicker: UIDatePicker!
    // 締め切り時間を入力するUITextField
    private var deadlineTextField: UITextField!
    // 保存ボタン
    private var saveButton: UIButton!
    
    // デリゲート
    weak var delegate: CreateTaskViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        taskTextField = UITextField()
        taskTextField.delegate = self
        taskTextField.tag = 0
        taskTextField.placeholder = "予定を入れてください"
        addSubview(taskTextField)
        
        deadlineTextField = UITextField()
        deadlineTextField.tag = 1
        deadlineTextField.placeholder = "期限を入れてください"
        addSubview(deadlineTextField)
        
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        // UITextFieldが編集モードになったときに、キーボードではなくUIDatePickerになるようにしている
        deadlineTextField.inputView = datePicker
        
        saveButton = UIButton()
        saveButton.setTitle("保存する", for: .normal)
        saveButton.setTitleColor(UIColor.black, for: .normal)
        saveButton.layer.borderWidth = 0.5
        saveButton.layer.cornerRadius = 4.0
        saveButton.addTarget(self, action: #selector(saveButtonTapped(_:)), for: .touchUpInside)
        addSubview(saveButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func saveButtonTapped(_ sender: UIButton) {
        delegate?.createView(saveButtonDidTap: self)
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        let deadlineText = dateFormatter.string(from: sender.date)
        deadlineTextField.text = deadlineText
        delegate?.createView(dealineEditting: self, deadline: sender.date)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        taskTextField.frame = CGRect(x: bounds.origin.x,
                                     y: bounds.origin.y,
                                     width: bounds.size.width - 60,
                                     height: 50)
        
        deadlineTextField.frame = CGRect(x: taskTextField.frame.origin.x,
                                         y: taskTextField.frame.maxY + 30,
                                         width: taskTextField.frame.size.width,
                                         height: taskTextField.frame.size.height)
        
        let saveButtonSize = CGSize(width: 100, height: 50)
        saveButton.frame = CGRect(x: (bounds.size.width - saveButtonSize.width) / 2,
                                  y: deadlineTextField.frame.maxY,
                                  width: saveButtonSize.width,
                                  height: saveButtonSize.height)
    }
}

extension CreateTaskView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 0 {
            delegate?.createView(taskEditing: self, text: textField.text ?? "")
        }
        
        return true
    }
}
