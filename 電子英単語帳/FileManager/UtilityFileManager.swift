//
//  UtilityFileManager.swift
//  電子英単語帳
//
//  Created by 藤井廉 on 2018/12/08.
//  Copyright © 2018年 university. All rights reserved.
//

import Foundation

class UtilityFileManager {
    //ファイルを探し、テキストをutf8に変換して返す。　注意：引数のfileNameには、拡張子まで渡す。
    static func loadFileText(fileName: String) -> String? {
        let fileComp = fileName.components(separatedBy: ".")
        guard fileComp.count == 2 else {
            print(fileName, "ファイル名の書き方に問題があります")
            return nil
        }
        guard let csvPath = Bundle.main.path(forResource: fileComp[0], ofType: fileComp[1]) else {
            print(fileName, "ファイルが見つかりません")
            return nil
        }
        do {
            return try String(contentsOfFile:csvPath, encoding:String.Encoding.utf8)
        } catch _ as NSError {
            print(fileName, "ファイルからテキストを取得できません")
        }
        return nil
    }
    
    //文字列を改行ごとの配列にして返す。改行のみの行は除く。
    static func getArrayLineText(fileText: String) -> [String] {
        var result: [String] = []
        for i in fileText.components(separatedBy: "\n") {
            if i.count > 0 {
                result.append(i)
            }
        }
        return result
    }
    
}
