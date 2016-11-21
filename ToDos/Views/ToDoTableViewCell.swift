//
//  ToDoTableViewCell.swift
//  ToDos
//
//  Created by Carlos Diez on 11/18/16.
//  Copyright © 2016 cdiezm. All rights reserved.
//

import UIKit

protocol ToDoTableViewCellDelegate: class {
  func toDoTableViewCell(_: ToDoTableViewCell, toggleCompletedFor toDo: ToDo)
  //func toggleCompleted(toDo: ToDo)
}

class ToDoTableViewCell: UITableViewCell {
  
  // MARK: Outlets
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var doneButton: UIButton!
  
  
  // MARK: Properties
  weak var delegate: ToDoTableViewCellDelegate?
  
  var toDo: ToDo? {
    didSet {
      titleLabel.text = toDo?.title
      descriptionLabel.text = toDo?.getDescriptionData().description
      descriptionLabel.textColor = toDo?.getDescriptionData().color
      doneButton.setTitle(toDo?.getButtonTitle(), for: .normal)
    }
  }
  
  
  // MARK: Actions
  
  @IBAction func doneButtonClicked(_ sender: AnyObject) {
    delegate?.toDoTableViewCell(self, toggleCompletedFor: toDo!)
  }
  
}
