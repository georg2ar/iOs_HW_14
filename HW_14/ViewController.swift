//
//  ViewController.swift
//  HW_14
//
//  Created by Юрий Четырин on 20.11.2019.
//  Copyright © 2019 Юрий Четырин. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var loginEdit: UITextField!
    @IBOutlet weak var passEdit: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginEdit.text = SaverUserData.shared.userName
        passEdit.text = SaverUserData.shared.pass
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        loginEdit.resignFirstResponder()
        passEdit.resignFirstResponder()
    }

    @IBAction func signInButton(_ sender: Any) {
        SaverUserData.shared.userName = loginEdit.text
        SaverUserData.shared.pass = passEdit.text
    }
    
}

