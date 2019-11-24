//
//  TaskCell.swift
//  HW_14
//
//  Created by Юрий Четырин on 20.11.2019.
//  Copyright © 2019 Юрий Четырин. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {

    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var taskLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
