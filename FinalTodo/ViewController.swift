//
//  ViewController.swift
//  FinalTodo
//
//  Created by Sarath P on 02/11/21.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    //reference to ns managed object context
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //data for the table
    var items: [Todo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //do any aditional setup after loading the view
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.yellow]
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //get the people from coredata
        fetchTodoList()
    }
    
    func fetchTodoList() {
        //fetch the data from tableview
        do {
            self.items = try context.fetch(Todo.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        } catch {
            print("error \(error.localizedDescription)")
        }
        
        
    }
    @IBAction func addTapped(_ sender: Any) {
        
        //create alert
        let alert = UIAlertController.init(title: "Todo", message: "Add something", preferredStyle: .alert)
        alert.addTextField()
        
        //configure button handler
        let submitButton = UIAlertAction(title: "Add", style: .default) { (action) in
            
            //get the textfield for alert
            let textField = alert.textFields![0]
            //TODO Create a person object
            if textField.text != "" {
            let newPerson = Todo(context: self.context)
            newPerson.todoList = textField.text
         
            
            //TODO save the data
            do {
               try self.context.save()
            } catch {
                print("Error")
            }
        }
            
            //TODO refetch the data
            self.fetchTodoList()
        }
        
        //add button
        alert.addAction(submitButton)
        
        
        //show alert
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        
        //get person from array and set the label
        let todoList = self.items![indexPath.row]
        cell.textLabel?.text = ("\(indexPath.row+1).  \(todoList.todoList!)")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //selected list
        let todoList = self.items![indexPath.row]
        
        //create alert
        let alert = UIAlertController(title: "Edit", message: "", preferredStyle: .alert)
        alert.addTextField()
        
        let textfield = alert.textFields![0]
        textfield.text = todoList.todoList
        
        //configure button handler
        
        let saveButton = UIAlertAction(title: "Save", style: .default) { (action) in
            let textfield = alert.textFields![0]
            
            let editList = self.items?[indexPath.row]
            //edit list property of list object
            
            editList?.todoList = textfield.text
            
            //save the data
            
            do {
               try self.context.save()
            } catch {}
            
            
            //refetch the data
            self.fetchTodoList()
        }
        
        //add button
        alert.addAction(saveButton)
        
        //show alert
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //create swipe action
        let action = UIContextualAction(style: .destructive, title: "remove") { (action, view, completionHandler) in
            
            
            //which list to remove
            
            let noteToRemove = self.items?[indexPath.row]
            
            
            //remove the person
            self.context.delete(noteToRemove!)
            
            //save the data
            do {
                try self.context.save()
            } catch{}
            
            //refetch the data
            self.fetchTodoList()
            
            
        }
        
        //return swipe actions
        
         return UISwipeActionsConfiguration(actions: [action])
    }
    
    
}

