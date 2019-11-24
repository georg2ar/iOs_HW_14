//
//  SaverUserData.swift
//  HW_14
//
//  Created by Юрий Четырин on 20.11.2019.
//  Copyright © 2019 Юрий Четырин. All rights reserved.
//

import Foundation

class SaverUserData{
    static let shared = SaverUserData()
    private let kUserNameKey = "SaverUserData.kUserNameKey"
    private let kPassKey = "SaverUserData.kPassKey"
    var userName: String?{
        set { UserDefaults.standard.set(newValue, forKey: kUserNameKey) }
        get { return UserDefaults.standard.string(forKey: kUserNameKey) }
    }
    var pass: String?{
        set { UserDefaults.standard.set(newValue, forKey: kPassKey) }
        get { return UserDefaults.standard.string(forKey: kPassKey) }
    }
}
