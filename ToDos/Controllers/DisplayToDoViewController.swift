//
//  DisplayToDoViewController.swift
//  ToDos
//
//  Created by Carlos Diez on 11/18/16.
//  Copyright © 2016 cdiezm. All rights reserved.
//

import UIKit

protocol DisplayToDoViewControllerDelegate: class {
  func toggleCompleted(toDo: ToDo)
  func removeToDo(toDo: ToDo)
}

class DisplayToDoViewController: UIViewController {
  
  // MARK: Outlets
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var doneButton: UIButton!
  
  
  // MARK: Properties
  var toDo: ToDo?
  weak var delegate: DisplayToDoViewControllerDelegate?
  var toDoCopy: ToDo!
  
  // MARK: View controller life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let existingToDo = toDo {
      self.navigationItem.title = existingToDo.title
      // I made a copy of the toDo so the delegate is not redundant and updates the tableview
      toDoCopy = existingToDo.copy() as! ToDo
      updateUI(forToDo: toDoCopy)
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  
  // MARK: Actions
  
  @IBAction func doneButtonClicked(_ sender: AnyObject) {
    toDoCopy.completed = !toDoCopy.completed
    updateUI(forToDo: toDoCopy)
    
    delegate?.toggleCompleted(toDo: toDo!)
  }
  
  @IBAction func deleteButtonClicked(_ sender: AnyObject) {
    delegate?.removeToDo(toDo: toDo!)
    self.performSegue(withIdentifier: "unwindToMyToDos", sender: self)
  }
  
  
  // MARK: helper functions
  func updateUI(forToDo toDo: ToDo) {
    descriptionLabel.text = toDo.getDescriptionData().description
    descriptionLabel.textColor = toDo.getDescriptionData().color
    
    if toDo.completed {
      doneButton.setTitle("Mark as undone❗️", for: .normal)
    }
    else {
      doneButton.setTitle("Mark as done ✅", for: .normal)
    }
  }
  
}
