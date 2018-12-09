//
//  UserData.swift
//  電子英単語帳
//
//  Created by 藤井廉 on 2018/12/09.
//  Copyright © 2018年 university. All rights reserved.
//

import Foundation

class UserData {
    static func get(title: String) -> [Bool]? {
        return UserDefaults.standard.array(forKey: title) as? [Bool]
    }
    
    static func save(data: [Bool], title: String) {
        UserDefaults.standard.set(data, forKey: title)
    }
    
    static func clearAll() {
        let appDomain = Bundle.main.bundleIdentifier
        UserDefaults.standard.removePersistentDomain(forName: appDomain!)
    }
}
