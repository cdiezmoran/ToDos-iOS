//
//  ToDo.swift
//  ToDos
//
//  Created by Carlos Diez on 11/18/16.
//  Copyright © 2016 cdiezm. All rights reserved.
//

import UIKit

class ToDo {
  var title: String
  var completed: Bool
  var deadline: Date
  
  init(title: String, completed: Bool, deadline: Date) {
    self.title = title
    self.completed = completed
    self.deadline = deadline
  }
  
  func getDescriptionData() -> (description: String, color: UIColor) {
    if completed {
      return (description: "You are done here 💪", color: UIColor.green)
    }
    
    let deadlineString = stringFromDeadline()
    return (description: "Deadline: \(deadlineString)", color: UIColor.red)
  }
  
  func stringFromDeadline() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    
    return dateFormatter.string(from: deadline)
  }
  
  func getButtonTitle() -> String {
    if completed {
      return "❗️"
    }
    else {
      return "✅"
    }
  }
  
  func copy() -> Any {
    let copy = ToDo(title: title, completed: completed, deadline: deadline)
    return copy
  }
}
