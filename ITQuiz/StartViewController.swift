//
//  StartViewController.swift
//  ITQuiz
//
//  Created by Yudai Terashita on 2018/06/05.
//  Copyright © 2018年 Yudai Terashita. All rights reserved.
//

import Foundation
import UIKit

class StartViewController:UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //次の画面に遷移する前に呼び出される準備処理
    override func prepare(for segue:UIStoryboardSegue,sender:Any?){
        
        //問題文の読み込み
        QuestionDataManager.sharedInstance.loadQuestion()
        
        //遷移先画面呼び出し
        guard let nextViewController = segue.destination as? QuestionViewController else{
            return
        }
        //問題文の取り出し
        guard let questionData = QuestionDataManager.sharedInstance.nextQuestion() else{
            return
        }
        //問題文のセット
        nextViewController.questionData = questionData
    }
    
    //タイトルに戻ってくるときに呼び出される処理
    @IBAction func goToTittle(_ segue:UIStoryboardSegue){
        
    }
}
