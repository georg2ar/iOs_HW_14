//
//  TaskCoreDataController.swift
//  HW_14
//
//  Created by Юрий Четырин on 23.11.2019.
//  Copyright © 2019 Юрий Четырин. All rights reserved.
//

import UIKit
import CoreData

class TaskCoreDataController: UIViewController {

    @IBOutlet weak var taskTableView: UITableView!
    var taskCollections: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //title = "Список задач"
        //taskTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TaskPersistanceCoreDate")
        
        do {
            taskCollections = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    @IBAction func addTaskButton(_ sender: Any) {
        let alert = UIAlertController(title: "Новая задача", message: "Добавьте новую задачу", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) {
            [unowned self] action in
            guard let textField = alert.textFields?.first,
                let nameToSave = textField.text else {
                    return
            }
            let date = self.getTodayString()
            
            self.save(name: nameToSave, date: date)
            self.taskTableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func getTodayString() -> String{
        
        let todaysDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm:ss"
        let dateInFormat = dateFormatter.string(from: todaysDate)

        return dateInFormat
    }
    
    
    func save(name: String, date: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "TaskPersistanceCoreDate", in: managedContext)!
        
        let task = NSManagedObject(entity: entity, insertInto: managedContext)
        
        task.setValue(name, forKeyPath: "textTask")
        task.setValue(date, forKey: "dateTimeTask")
        
        do {
            try managedContext.save()
            taskCollections.append(task)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func remove(name: String, date: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskPersistanceCoreDate")
        fetchRequest.predicate = NSPredicate(format: "dateTimeTask = %@", date)
        
        do{
            let fetch = try managedContext.fetch(fetchRequest)
            
            let objectToDelete = fetch[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            
            do{
                try managedContext.save()
            }
            catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }

}

extension TaskCoreDataController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskCollections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = taskCollections[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCellCoreData") as! TaskCell
        cell.dateTimeLabel.text = task.value(forKeyPath: "dateTimeTask") as? String
        cell.taskLabel.text = task.value(forKeyPath: "textTask") as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = taskCollections[indexPath.row]
            self.remove(name: (task.value(forKeyPath: "textTask") as? String)!, date: (task.value(forKeyPath: "dateTimeTask") as? String)!)
            self.taskCollections.remove(at: indexPath.row)
            self.taskTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Удалить"
    }
}
