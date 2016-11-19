//
//  ViewController.swift
//  ToDos
//
//  Created by Carlos Diez on 11/18/16.
//  Copyright © 2016 cdiezm. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {
  
  // MARK: Properties
  var ToDos: [ToDo] = [ToDo(title: "Go grocery shopping", completed: false, deadLine: "18/11/2016"),
                       ToDo(title: "Workout", completed: false, deadLine: "19/11/2016")]
  
  
  // MARK: View controller's life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showToDo" {
      
    }
  }
  
  
  // MARK: Table view methods

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return ToDos.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell") as! ToDoTableViewCell
    
    let toDo = ToDos[indexPath.row]
    
    cell.toDo = toDo
    cell.delegate = self
    
    return cell
  }
}


extension ToDoTableViewController: ToDoTableViewCellDelegate {
  func toggleCompleted(toDo: ToDo) {
    toDo.completed = !toDo.completed
    
    tableView.reloadData()
  }
}

