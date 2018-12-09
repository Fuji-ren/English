//
//  SettingViewController.swift
//  電子英単語帳
//
//  Created by 藤井廉 on 2018/12/08.
//  Copyright © 2018年 university. All rights reserved.
//

import UIKit

//学習方式設定画面
class SettingViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var learnTypeSegment: UISegmentedControl!
    @IBOutlet weak var countAllQuestionLabel: UILabel!
    @IBOutlet weak var countWeakQuestionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = WordFileManager.share.title
        setSegment()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        countAllQuestionLabel.text = String(WordFileManager.share.words.count) + "問"
        
        //苦手単語を取得(苦手単語をセットして取得している、非効率)
        QuestionManager.setWeakQuestion()
        countWeakQuestionLabel.text = String(QuestionManager.questions.count) + "問"
    }
    //セグメントコントローラの値を設定する
    private func setSegment() {
        //UserDefaultsでセグメントコントローラが保存できないのでIntで保存
        let index = UserDefaults.standard.integer(forKey: "Segment")
        if index >= 0 && index <= 1 {
            learnTypeSegment.selectedSegmentIndex = index
        }
    }
    
    private func goToNextVC() {
        guard QuestionManager.questions.count > 0 else {
            return
        }
        //セグメントコントローラによって次の画面を選別する
        var nextVCID = ""
        switch learnTypeSegment.selectedSegmentIndex {
        case 0:
            nextVCID = "FlashcardViewController"  //単語帳式
        default:
            nextVCID = "ChoicesViewController"  //選択問題式
        }
        guard let vc = storyboard?.instantiateViewController(withIdentifier: nextVCID) else {
            return
        }
        present(vc, animated: true, completion: nil)
    }
    
    //全問題
    @IBAction func allQuestionButtonTouched(_ sender: Any) {
        QuestionManager.setAllQuestion()
        goToNextVC()
    }
    //苦手のみ
    @IBAction func weakQuestionButtonTouched(_ sender: Any) {
        QuestionManager.setWeakQuestion()
        goToNextVC()
    }
    
    @IBAction func backButtonTouched(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    //学習方式選択セグメントがタップされると、そのセグメントのデータを保存
    @IBAction func segmentTouched(_ sender: Any) {
        UserDefaults.standard.set(learnTypeSegment.selectedSegmentIndex, forKey: "Segment")
    }
}
