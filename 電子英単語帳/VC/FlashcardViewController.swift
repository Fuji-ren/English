//
//  FlashcardViewController.swift
//  電子英単語帳
//
//  Created by 藤井廉 on 2018/12/08.
//  Copyright © 2018年 university. All rights reserved.
//

import UIKit

//単語帳式学習画面
class FlashcardViewController: UIViewController {

    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var wordClassLabel: UILabel!
    @IBOutlet weak var meanLabel: UILabel!
    @IBOutlet weak var answerButton: UIButton!
    @IBOutlet weak var weakButton: UIButton!
    
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
        answerButton.isEnabled = true
        weakButton.isEnabled = false
    }
    
    private func goToResultView() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ResultViewController") else {
            return
        }
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func answerButtonTouched(_ sender: UIButton) {
        meanLabel.alpha = 1
        answerButton.isEnabled = false
        weakButton.isEnabled = true
    }
    @IBAction func finishedButtonTouched(_ sender: Any) {
        //済を選択したことをQuestionManagerに知らせる。まだUserDefaultsには保存されない。
        QuestionManager.setUserState(weakState: false)
        mainDisposal()
    }
    @IBAction func yetButtonTouched(_ sender: Any) {
        QuestionManager.setUserState(weakState: true)
        mainDisposal()
    }
}
