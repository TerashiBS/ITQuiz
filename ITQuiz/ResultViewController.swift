//
//  ResultViewController.swift
//  ITQuiz
//
//  Created by Yudai Terashita on 2018/06/05.
//  Copyright © 2018年 Yudai Terashita. All rights reserved.
//

import Foundation
import UIKit

class ResultViewController:UIViewController{
    
    @IBOutlet weak var correctPercentLabel: UILabel!     //正解ラベル
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //問題数を取得
        let questionCount = QuestionDataManager.sharedInstance.questionDataArray.count
        
        //正解数を取得
        var correctCount :Int = 0
        for questionData in QuestionDataManager.sharedInstance.questionDataArray{
            //正解数を計算する
            if questionData.isCorrect(){
                correctCount += 1            //正解数を増やす
            }
        }
        let correctPercent :Float = (Float(correctCount)/Float(questionCount))*100 //正解率の計算
        
        correctPercentLabel.text = String(format:"%.01f",correctPercent)+"%"  //正解率を少数第一まで計算
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
