//
//  ShuffleArray.swift
//  電子英単語帳
//
//  Created by 藤井廉 on 2018/12/09.
//  Copyright © 2018年 university. All rights reserved.
//

import Foundation
extension Array {
    mutating func shuffle() {
        for i in 0..<self.count {
            let j = Int(arc4random_uniform(UInt32(self.indices.last!)))
            if i != j {
                self.swapAt(i, j)
            }
        }
    }
}
