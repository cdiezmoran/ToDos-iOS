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
  var sectionTitles = ["Undone", "Done"]
  
  var toDos: [[ToDo]] = [[], []] {
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
      let toDo = toDos[indexPath.section][indexPath.row]
      
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
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return toDos.count
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if section < sectionTitles.count {
      return sectionTitles[section]
    }
    
    return nil
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return toDos[section].count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell") as! ToDoTableViewCell
    
    let toDo = toDos[indexPath.section][indexPath.row]
    
    cell.toDo = toDo
    cell.delegate = self
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      toDos[indexPath.section].remove(at: indexPath.row)
    }
  }
  
  
  // MARK: Helper methods
  
  func toggleCompleted(toDo: ToDo) {
    remove(toDo: toDo)
    
    toDo.completed = !toDo.completed
    
    if toDo.completed {
      toDos[1].append(toDo)
    }
    else {
      toDos[0].append(toDo)
    }
    
    tableView.reloadData()
  }
  
  func remove(toDo: ToDo) {
    for section in 0..<2 {
      for index in 0..<toDos[section].count {
        if toDos[section][index] === toDo {
          toDos[section].remove(at: index)
          return
        }
      }
    }
  }
  
  func modify(toDo: ToDo, title: String, deadline: Date) {
    toDo.title = title
    toDo.deadline = deadline
    
    tableView.reloadData()
  }
}


// MARK: Extensions

extension ToDoTableViewController: ToDoTableViewCellDelegate {
  func toDoTableViewCell(_: ToDoTableViewCell, toggleCompletedFor toDo: ToDo) {
    toggleCompleted(toDo: toDo)
  }
}


extension ToDoTableViewController: DisplayToDoViewControllerDelegate {
  func displayToDoViewController(_: DisplayToDoViewController, toggleCompletedFor toDo: ToDo) {
    toggleCompleted(toDo: toDo)
  }
  
  func displayToDoViewController(_: DisplayToDoViewController, remove toDo: ToDo) {
    remove(toDo: toDo)
  }
  
  func displayToDoViewController(_: DisplayToDoViewController, modify toDo: ToDo, withTitle title: String, withDeadline deadline: Date) {
    modify(toDo: toDo, title: title, deadline: deadline)
  }
}

extension ToDoTableViewController: AddToDoViewControllerDelegate {
  func addToDoViewController(_: AddToDoViewController, add toDo: ToDo) {
    toDos[0].append(toDo)
  }
  
  func addToDoViewController(_: AddToDoViewController, modify toDo: ToDo, withTitle title: String, withDeadline deadline: Date) {
  }
}

