//
//  QuestionManager.swift
//  電子英単語帳
//
//  Created by 藤井廉 on 2018/12/08.
//  Copyright © 2018年 university. All rights reserved.
//

import Foundation

class QuestionManager {
    private static var wordFileData = WordFileManager.share
    private static var question: [WordData] = []
    private static var nowIndex = 0
    private static var resultArray: [Bool] = []
    
    static var questions: [WordData] {
        return question
    }
    static var getUserResult: [Bool] {
        return resultArray
    }
    
    static private func setResultArray() {
        if let data = UserData.get(title: wordFileData.title) {
            resultArray = data
        } else {
            resultArray = [Bool](repeating: false, count: wordFileData.words.count)
        }
    }
    
    static func setAllQuestion() {
        nowIndex = 0
        question = wordFileData.words
        question.shuffle()
        setResultArray()
    }
    
    static func setWeakQuestion() {
        nowIndex = 0
        setResultArray()
        question = []
        for i in wordFileData.words {
            if resultArray[i.number] == true {
                question.append(i)
            }
        }
    }
    
    static func getQuestion() -> WordData? {
        guard nowIndex < question.count, nowIndex >= 0 else {
            return nil
        }
        return question[nowIndex]
    }
    
    //weakStateは苦手問題の場合にtrue
    static func setUserState(weakState: Bool) {
        guard nowIndex < question.count, nowIndex < resultArray.count, nowIndex >= 0 else {
            return
        }
        resultArray[question[nowIndex].number] = weakState
        nowIndex += 1
    }
    
    static func saveUserResult() {
        UserData.save(data: resultArray, title: wordFileData.title)
    }
    
}
