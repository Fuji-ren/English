//
//  TitleViewController.swift
//  電子英単語帳
//
//  Created by 藤井廉 on 2018/12/08.
//  Copyright © 2018年 university. All rights reserved.
//

import UIKit

//教材選択画面
class TitleViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func deleteUserDataButtonTouched(_ sender: Any) {
        let alert = UIAlertController(title: "データを削除します", message: "よろしいですか？", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "yes", style: .default, handler: {(UIAlertAction) -> Void in
            UserData.clearAll()
        }))
        alert.addAction(UIAlertAction(title: "no", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

extension TitleViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TitleFileManager.shared.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = TitleFileManager.shared.data[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectFile = TitleFileManager.shared.data[indexPath.row]
        //選択されたcsvファイルから単語データを取得する
        guard WordFileManager.share.setWords(fileTitle: selectFile.title, fileName: selectFile.toFileString) == true else {
            return
        }
        guard WordFileManager.share.words.count > 0,
              let vc = storyboard?.instantiateViewController(withIdentifier: "SettingViewController") else {
            print("次の画面が取得できませんでした")
            return
        }
        present(vc, animated: true, completion: nil)
    }
}
