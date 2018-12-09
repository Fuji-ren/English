//
//  ResultViewCell.swift
//  電子英単語帳
//
//  Created by 藤井廉 on 2018/12/09.
//  Copyright © 2018年 university. All rights reserved.
//

import UIKit

class ResultViewCell: UITableViewCell {

    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var meanLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setLabels(index: Int) {
        let question = QuestionManager.questions[index]
        wordLabel.text = question.word
        meanLabel.text = question.mean
        if QuestionManager.getUserResult[question.number] == false {
            stateLabel.text = "済"
            stateLabel.textColor = UIColor.red
        } else {
            stateLabel.text = "未"
            stateLabel.textColor = UIColor.blue
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
