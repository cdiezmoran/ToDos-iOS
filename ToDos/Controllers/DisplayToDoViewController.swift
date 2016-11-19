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
  var toDo: ToDo! {
    didSet {
      descriptionLabel.text = toDo.getDescriptionData().description
      descriptionLabel.textColor = toDo.getDescriptionData().color
      
      if toDo.completed {
        doneButton.setTitle("Mark as done  ✅", for: .normal)
      }
      else {
        doneButton.setTitle("Mark as undone  ❗️", for: .normal)
      }
    }
  }
  
  
  // MARK: View controller life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  
  // MARK: Actions
  
  @IBAction func doneButtonClicked(_ sender: AnyObject) {
    
  }
  
  @IBAction func deleteButtonClicked(_ sender: AnyObject) {
    
  }
  
}
