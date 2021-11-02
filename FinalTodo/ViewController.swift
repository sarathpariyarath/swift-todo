//
//  ViewController.swift
//  FinalTodo
//
//  Created by Sarath P on 02/11/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //reference to managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //data for the table
    var items: [Person]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //get people from coredata
        fetchPeople()
    }
    
    func fetchPeople() {
        
    }
    @IBAction func addTapped(_ sender: Any) {
        
        //create alert
        let alert = UIAlertController.init(title: "Add Person", message: "What is their name?", preferredStyle: .alert)
        alert.addTextField()
        
        //configure button handler
        let submitButton = UIAlertAction(title: "Add", style: .default) { (action) in
            
            //get the textfield for the alert
            let textField = alert.textFields![0]
            
            //TODO Create a person object
            
            //TODO save the data
            
            //TODO to refetch the data
            
            
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
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}

