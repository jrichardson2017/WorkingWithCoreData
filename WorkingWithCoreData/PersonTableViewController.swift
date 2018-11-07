//
//  PersonTableViewController.swift
//  WorkingWithCoreData
//
//  Created by Justin Richardson on 2018-11-01.
//  Copyright © 2018 Justin Richardson. All rights reserved.
//

import UIKit
import CoreData

class PersonTableViewController: UITableViewController {
    
    // MARK: - Variables
    var people = [Person]()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "People"
        tableView.rowHeight = 60
        readSavedData()
    }

    // MARK: - Actions
    @IBAction func onAddTapped() {
        let alert = createAlert(title: "Add Person")
        let action = createAction(for: alert, title: "Add")
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func unwindOnUpdateTapped(_ sender: UIStoryboardSegue) {
        guard let detailViewController = sender.source as? DetailViewController else { return }
        detailViewController.performUpdate()
        updateSavedData(from: detailViewController)
    }
    
    // MARK: - Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailViewController = segue.destination as? DetailViewController else { return }
        
        guard let cell = sender as? UITableViewCell else { return }
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        detailViewController.indexPath = indexPath.row
        if let name = people[indexPath.row].name {
            detailViewController.name = name
        }
        let age = people[indexPath.row].age
        detailViewController.age = Int16(age)
    }
    
    func createAlert(title: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Name"
            textField.autocapitalizationType = .words
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Age"
            textField.keyboardType = .numberPad
        }
        return alert
    }
    
    func createAction(for alert: UIAlertController, title: String) -> UIAlertAction {
        let action = UIAlertAction(title: title, style: .default) { [weak self] (_) in
            guard let name = alert.textFields?.first?.text else { return }
            guard let age = alert.textFields?.last?.text else { return }
            let context = PersistenceManager.context
            let person = Person(context: context)
            person.name = name
            person.age = Int16(age) ?? 0
            PersistenceManager.saveContext()
            self?.people.append(person)
            self?.tableView.reloadData()
        }
        return action
    }
    
    func readSavedData() {
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        do {
            let results = try PersistenceManager.context.fetch(request)
            people = results
        } catch {
            print("No data available")
        }
    }
    
    func updateSavedData(from detailViewController: DetailViewController) {
        let indexPath = detailViewController.indexPath
        let person = people[indexPath]
        person.name = detailViewController.name
        person.age = detailViewController.age
        PersistenceManager.saveContext()
        tableView.reloadData()
    }
    
    func deleteSavedData(at indexPath: Int) {
        let person = people[indexPath]
        PersistenceManager.context.delete(person)
        tableView.reloadData()
    }

}

extension PersonTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath) as? PersonCell
        let backupCell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell?.nameLabel.text = people[indexPath.row].name
        cell?.ageLabel.text = String(people[indexPath.row].age)
        return cell ?? backupCell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        deleteSavedData(at: indexPath.row)
        people.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
}
