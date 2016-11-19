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
  var toDos = [ToDo]() {
    didSet {
      tableView.reloadData()
    }
  }
  
  
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
      let displayToDoViewController = segue.destination as! DisplayToDoViewController
      
      let indexPath = tableView.indexPathForSelectedRow!
      let toDo = toDos[indexPath.row]
      
      displayToDoViewController.toDo = toDo
      displayToDoViewController.delegate = self
    }
    else if segue.identifier == "addToDo" {
      let addToDoViewController = segue.destination as! AddToDoViewController
      addToDoViewController.delegate = self
    }
  }
  
  @IBAction func unwindToMyToDos(segue: UIStoryboardSegue) {
  
  }
  
  
  // MARK: Table view methods

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return toDos.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell") as! ToDoTableViewCell
    
    let toDo = toDos[indexPath.row]
    
    cell.toDo = toDo
    cell.delegate = self
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      toDos.remove(at: indexPath.row)
    }
  }
}


// MARK: Extensions

extension ToDoTableViewController: ToDoTableViewCellDelegate {
  func toggleCompleted(toDo: ToDo) {
    toDo.completed = !toDo.completed
    
    tableView.reloadData()
  }
}


extension ToDoTableViewController: DisplayToDoViewControllerDelegate {
  func removeToDo(toDo: ToDo) {
    for index in 0..<toDos.count {
      if toDos[index] === toDo {
        toDos.remove(at: index)
      }
    }
  }
}

extension ToDoTableViewController: AddToDoViewControllerDelegate {
  func addToDo(toDo: ToDo) {
    toDos.append(toDo)
  }
}

