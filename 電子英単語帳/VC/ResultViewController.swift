//
//  ResultViewController.swift
//  電子英単語帳
//
//  Created by 藤井廉 on 2018/12/09.
//  Copyright © 2018年 university. All rights reserved.
//

import UIKit

//学習結果画面
class ResultViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ResultViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        //ここで問題の正誤を保存する
        QuestionManager.saveUserResult()
    }
    
    @IBAction func backButtonTouched(_ sender: Any) {
        presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

extension ResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QuestionManager.questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ResultViewCell else {
            return UITableViewCell()
        }
        cell.setLabels(index: indexPath.row)
        return cell
    }
}
