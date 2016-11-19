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
  var deadLine: String
  
  init(title: String, completed: Bool, deadLine: String) {
    self.title = title
    self.completed = completed
    self.deadLine = deadLine
  }
  
  func getDescriptionData() -> (description: String, color: UIColor) {
    if completed {
      return (description: "You are done here 💪", color: UIColor.green)
    }
    
    return (description: "Deadline: \(deadLine)", color: UIColor.red)
  }
  
  func getButtonTitle() -> String {
    if completed {
      return "❗️"
    }
    else {
      return "✅"
    }
  }
  
  func copy(with zone: NSZone? = nil) -> Any {
    let copy = ToDo(title: title, completed: completed, deadLine: deadLine)
    return copy
  }
}
