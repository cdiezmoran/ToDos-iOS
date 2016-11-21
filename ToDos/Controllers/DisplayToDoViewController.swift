//
//  DisplayToDoViewController.swift
//  ToDos
//
//  Created by Carlos Diez on 11/18/16.
//  Copyright © 2016 cdiezm. All rights reserved.
//

import UIKit

protocol DisplayToDoViewControllerDelegate: class {
  func displayToDoViewController(_: DisplayToDoViewController, toggleCompletedFor toDo: ToDo)
  func displayToDoViewController(_: DisplayToDoViewController, remove toDo: ToDo)
  func displayToDoViewController(_: DisplayToDoViewController, modify toDo: ToDo, withTitle title: String, withDeadline deadline: Date)
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
      // I made a copy of the toDo so the delegate is not redundant and updates the tableview
      toDoCopy = existingToDo.copy() as! ToDo
      updateUI(for: toDoCopy)
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "modifyToDo" {
      let addToDoViewController = segue.destination as! AddToDoViewController
      
      addToDoViewController.delegate = self
      addToDoViewController.toDo = toDo
    }
  }
  
  
  // MARK: Actions
  
  @IBAction func doneButtonClicked(_ sender: AnyObject) {
    toDoCopy.completed = !toDoCopy.completed
    updateUI(for: toDoCopy)
    
    delegate?.displayToDoViewController(self, toggleCompletedFor: toDo!)
  }
  
  @IBAction func deleteButtonClicked(_ sender: AnyObject) {
    delegate?.displayToDoViewController(self, remove: toDo!)
    self.performSegue(withIdentifier: "unwindToMyToDos", sender: self)
  }
  
  
  // MARK: helper functions
  func updateUI(for toDo: ToDo) {
    self.navigationItem.title = toDo.title
    
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

extension DisplayToDoViewController: AddToDoViewControllerDelegate {
  func addToDoViewController(_: AddToDoViewController, modify toDo: ToDo, withTitle title: String, withDeadline deadline: Date) {
    toDoCopy.title = title
    toDoCopy.deadline = deadline
    
    updateUI(for: toDoCopy)
    delegate?.displayToDoViewController(self, modify: toDo, withTitle: title, withDeadline: deadline)
  }
  
  func addToDoViewController(_: AddToDoViewController, add toDo: ToDo) {
  }
}
