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
    
    let context = CoredataManager.shared.persistentContainer.viewContext
    
    //data for the table
    var items: [Todo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //do any aditional setup after loading the view
        
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
    func buttonTapped (hello: String) {
        let attributedString = NSAttributedString(string: hello, attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),
            NSAttributedString.Key.foregroundColor : UIColor.red
        ])
        //create alert
        let alert = UIAlertController.init(title: "Todo", message: "", preferredStyle: .alert)
        alert.setValue(attributedString, forKey: "attributedMessage")
        alert.addTextField()
        
        
        //configure button handler
        let submitButton = UIAlertAction(title: "Add", style: .default) { (action) in
            
            //get the textfield for alert
            let textField = alert.textFields![0]
            textField.placeholder = "Enter Something"
            //TODO Create a person object
            if textField.text!.count >= 5 {
                let newTodo = Todo(context: self.context)
                newTodo.todoList = textField.text
                
                
                
                //TODO save the data
                do {
                    try self.context.save()
                } catch {
                    print("Error")
                }
            } else{
                if textField.text == "" {
                    self.buttonTapped(hello: "Enter Something")
                }else {
                    self.buttonTapped(hello: "Enter minimum 5 characters")
                }
                
            }
            //TODO refetch the data
            self.fetchTodoList()
            
        }
        //cacnel button
        let cancelButoon = UIAlertAction(title: "Cancel", style: .cancel)
        //add button
        alert.addAction(submitButton)
        alert.addAction(cancelButoon)
        
        
        //show alert
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func addTapped(_ sender: Any) {
        
        buttonTapped(hello: "")
        
    }
    func editData() {
        
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
        
        
        
        cell.accessoryType = .none
        cell.tintColor = UIColor.red
        if  todoList.state == true {
            cell.textLabel?.text = "✓  \(todoList.todoList!)"
            
            
        }else {
            cell.textLabel?.text = "  \(todoList.todoList!)"
            cell.textLabel?.textColor = .white
        }
        print("\(todoList.todoList!) \(todoList.state)")
        
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
            if textfield.text!.count >= 5 {
                let editList = self.items?[indexPath.row]
                //edit list property of list object
                
                editList?.todoList = textfield.text
                
                //save the data
                
                do {
                    try self.context.save()
                } catch {}
                
            }
            
            //refetch the data
            self.fetchTodoList()
        }
        let cancelButoon = UIAlertAction(title: "Cancel", style: .cancel)
        //add button
        alert.addAction(saveButton)
        alert.addAction(cancelButoon)
        
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
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let hello = self.items?[indexPath.row]
        
        print(hello!)
        let action = UIContextualAction(style: .destructive, title: "Mark as done") {  (action, view, completionHandler) in}
        hello?.state.toggle()
        //return swipe actions
        do {
            try self.context.save()
        } catch{}
        tableView.reloadData()
        return UISwipeActionsConfiguration(actions: [action])
        
    }
    
}

