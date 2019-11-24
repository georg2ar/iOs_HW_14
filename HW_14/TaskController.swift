//
//  TaskController.swift
//  HW_14
//
//  Created by Юрий Четырин on 20.11.2019.
//  Copyright © 2019 Юрий Четырин. All rights reserved.
//

import UIKit

class TaskController: UIViewController {

    @IBOutlet weak var taskTableView: UITableView!
    
    //var taskCollections: [(date:String, textTask: String)] = []
    var taskCollections: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskCollections = ToDoTaskRealm.shared.getTasks()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? NewTaskController, segue.identifier == "ShowNewTaskEdit"{
            vc.delegate = self
        }
    }
    
    func getTodayString() -> String{
        
        let todaysDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm:ss"
        let dateInFormat = dateFormatter.string(from: todaysDate)

        return dateInFormat
    }

}

extension TaskController:NewTaskControllerDelegate{
    func setTaskText(_ text: String) {
        let today : String!
        today = getTodayString()
        let task = Task()
        task.dateTimeTask = today
        task.textTask = text
        taskCollections.append(task)
        ToDoTaskRealm.shared.addTask(date: today, textTask: text)
        taskTableView.reloadData()
    }
}

extension TaskController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskCollections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = taskCollections[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell") as! TaskCell
        cell.dateTimeLabel.text = task.dateTimeTask
        cell.taskLabel.text = task.textTask
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ToDoTaskRealm.shared.removeTask(task: taskCollections[indexPath.row])
            self.taskCollections.remove(at: indexPath.row)
            self.taskTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Удалить"
    }
    
}
