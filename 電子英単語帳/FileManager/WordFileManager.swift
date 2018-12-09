//
//  WordFileManager.swift
//  電子英単語帳
//
//  Created by 藤井廉 on 2018/12/08.
//  Copyright © 2018年 university. All rights reserved.
//

import Foundation

class WordFileManager {
    var words = [WordData]()
    var title = ""
    
    static let share = WordFileManager()
    private init() {}
    
    //単語ファイルを探し、取得したデータをプロパティに入れる。成功したらture、失敗したらfalse
    func setWords(fileTitle: String, fileName: String) -> Bool{
        title = fileTitle
        if let dataString = UtilityFileManager.loadFileText(fileName: fileName) {
            let lineDataArray = UtilityFileManager.getArrayLineText(fileText: dataString)
            return setData(lineData: lineDataArray)
        }
        return false
    }
    
    //単語ファイル1行ずつの配列を引数に取り、文字列を分解してwordsプロパティにデータを入れる、エラーがあればfalseを返す
    private func setData(lineData: [String]) -> Bool {
        var safeFlag = true //エラーがあるとfaluseにする
        let wDataElem = 5 //WordDataの要素数
        words = []
        var nowRow = 0 //エラー行の出力用
        for i in lineData {
            nowRow += 1
            let array = i.components(separatedBy: ",")
            guard array.count == wDataElem, let number = Int(array[0]), number == nowRow - 1 else {
                print(nowRow, "行目", title, "ファイルの書き方に問題があります\n", i)
                words = []
                safeFlag = false
                continue
            }
            let selectionArray = array[wDataElem - 1].components(separatedBy: "|")
            guard selectionArray.count == 3 else {
                print(nowRow, "行目", title, "ファイルの選択肢の書き方に問題があります\n", array[wDataElem - 1])
                words = []
                safeFlag = false
                continue
            }
            words.append(WordData(number: number, word: array[1], wordClass: array[2], mean: array[3], selection: selectionArray))
        }
        return safeFlag
    }
}
