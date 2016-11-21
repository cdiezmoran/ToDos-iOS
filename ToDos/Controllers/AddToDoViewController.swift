//
//  AddToDoViewController.swift
//  ToDos
//
//  Created by Carlos Diez on 11/18/16.
//  Copyright © 2016 cdiezm. All rights reserved.
//

import UIKit

protocol AddToDoViewControllerDelegate: class {
  func addToDoViewController(_: AddToDoViewController, add toDo: ToDo)
  func addToDoViewController(_: AddToDoViewController, modify toDo: ToDo, withTitle title: String, withDeadline deadline: Date)
}

class AddToDoViewController: UIViewController {
  
  // MARK: Outlets
  @IBOutlet var titleTextField: UITextField!
  @IBOutlet var deadlinePickerView: UIDatePicker!
  @IBOutlet var saveButton: UIButton!
  
  
  // MARK: Properties
  weak var delegate: AddToDoViewControllerDelegate?
  var toDo: ToDo?
  
  
  // MARK: View controller life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    saveButton.isEnabled = false
    
    if let existingToDo = toDo {
      titleTextField.text = existingToDo.title
      deadlinePickerView.date = existingToDo.deadline
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  
  // MARK: Actions
  
  @IBAction func saveButtonClicked(_ sender: AnyObject) {
    let title = titleTextField.text!
    let deadline = deadlinePickerView.date
    
    if let existingToDo = toDo {
      delegate?.addToDoViewController(self, modify: existingToDo, withTitle: title, withDeadline: deadline)
    }
    else {
      let newToDo = ToDo(title: title, completed: false, deadline: deadline)
      
      delegate?.addToDoViewController(self, add: newToDo)
    }
    dismissViewController()
  }
  
  @IBAction func cancelButtonClicked(_ sender: AnyObject) {
    dismissViewController()
  }
  
  @IBAction func titleFieldChanged(_ sender: UITextField) {
    if sender.text != "" {
      saveButton.isEnabled = true
    }
    else {
      saveButton.isEnabled = false
    }
  }
  

  // MARK: Helper methods
  
  func dismissViewController() {
    presentingViewController?.dismiss(animated: true)
  }
}
