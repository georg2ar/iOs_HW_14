//
//  NewTaskController.swift
//  HW_14
//
//  Created by Юрий Четырин on 21.11.2019.
//  Copyright © 2019 Юрий Четырин. All rights reserved.
//

import UIKit

protocol NewTaskControllerDelegate{
    func setTaskText(_ text:String)
}
class NewTaskController: UIViewController {

    var delegate:NewTaskControllerDelegate?
    
    @IBOutlet weak var taskViewEdit: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        taskViewEdit.resignFirstResponder()
    }
    
    @IBAction func saveTaskButton(_ sender: Any) {
        delegate?.setTaskText(taskViewEdit.text)
        _ = navigationController?.popViewController(animated: true)
    }
    

}
