//
//  AddToDoViewController.swift
//  ToDos
//
//  Created by Carlos Diez on 11/18/16.
//  Copyright © 2016 cdiezm. All rights reserved.
//

import UIKit

protocol AddToDoViewControllerDelegate: class {
  func addToDo(toDo: ToDo)
}

class AddToDoViewController: UIViewController {
  
  // MARK: Outlets
  @IBOutlet var titleTextField: UITextField!
  @IBOutlet var deadlinePickerView: UIDatePicker!
  @IBOutlet var saveButton: UIButton!
  
  
  // MARK: Properties
  weak var delegate: AddToDoViewControllerDelegate?
  
  
  // MARK: View controller life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    saveButton.isEnabled = false
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  
  // MARK: Actions
  
  @IBAction func saveButtonClicked(_ sender: AnyObject) {
    let title = titleTextField.text
    let date = deadlinePickerView.date
    
    let newToDo = ToDo(title: title!, completed: false, deadline: date)
    
    delegate?.addToDo(toDo: newToDo)
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
