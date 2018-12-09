//
//  ChoicesViewController.swift
//  電子英単語帳
//
//  Created by 藤井廉 on 2018/12/08.
//  Copyright © 2018年 university. All rights reserved.
//

import UIKit

//選択問題式学習画面
class ChoicesViewController: UIViewController {

    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var wordClassLabel: UILabel!
    @IBOutlet var choiceLabel: [UIButton]!
    @IBOutlet weak var noChoiceLabel: UIButton!
    @IBOutlet weak var meanLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainDisposal()
    }
    
    private func mainDisposal() {
        if let question = QuestionManager.getQuestion() {
            drawView(question)
        } else {
            goToResultView()
        }
    }
    
    private func drawView(_ question: WordData) {
        wordLabel.text = question.word
        wordClassLabel.text = question.wordClass
        meanLabel.text = question.mean
        meanLabel.alpha = 0
        resultLabel.text = ""
        
        //選択肢ボタンのテキストを描画する
        var choices = question.selection
        choices.append(question.mean)
        guard choices.count >= choiceLabel.count else {
            return
        }
        choices.shuffle()
        for i in 0..<choiceLabel.count {
            choiceLabel[i].setTitle(choices[i], for: .normal)
            choiceLabel[i].isEnabled = true
        }
        noChoiceLabel.isEnabled = true
    }
    
    private func goToResultView() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ResultViewController") else {
            return
        }
        present(vc, animated: true, completion: nil)
    }

    @IBAction func choiceButtonTouched(_ sender: UIButton) {
        meanLabel.alpha = 1
        //一旦、全選択肢を押せなくする（選択肢をダブルタップすると続けて処理される為）
        for button in choiceLabel {
            button.isEnabled = false
        }
        noChoiceLabel.isEnabled = false
        
        if sender.titleLabel?.text == meanLabel.text {
            QuestionManager.setUserState(weakState: false)
            resultLabel.text = "○"
            resultLabel.textColor = UIColor.red
        } else {
            QuestionManager.setUserState(weakState: true)
            resultLabel.text = "×"
            resultLabel.textColor = UIColor.blue
        }
        //２秒後に次の問題への処理をする
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.mainDisposal()
        })
    }
    
}
