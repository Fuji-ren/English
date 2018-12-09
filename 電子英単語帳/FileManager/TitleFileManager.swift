//
//  TitleFileManager.swift
//  電子英単語帳
//
//  Created by 藤井廉 on 2018/12/08.
//  Copyright © 2018年 university. All rights reserved.
//

import Foundation

class TitleFileManager {
    var data = [(title: String, toFileString: String)]()
    private let separator = ","

    //シングルトン
    static let shared = TitleFileManager()
    
    private init() {
        guard let dataString = UtilityFileManager.loadFileText(fileName: "Title.csv") else {
            return
        }
        let lineDataArray = UtilityFileManager.getArrayLineText(fileText: dataString)
        setData(lineData: lineDataArray)
    }
    //dataプロパティに教材一覧ファイルの内容を設定する
    private func setData(lineData: [String]) {
        var nowRow = 0 //エラー行出力用
        for i in lineData {
            nowRow += 1
            let array = i.components(separatedBy: separator)
            //取得したデータが仕様通りの要素数か確認して追加。仕様と違う場合は、エラー文を出力する。
            //仕様と違う行は除くだけで他の行は影響なく処理される。
            if array.count == 2 {
                data.append((title: array[0], toFileString: array[1]))
            } else {
                print("Titleファイル", nowRow, "行目に問題があります")
            }
        }
    }
    
}
