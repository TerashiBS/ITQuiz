//
//  QuestionViewController.swift
//  ITQuiz
//
//  Created by Yudai Terashita on 2018/06/05.
//  Copyright © 2018年 Yudai Terashita. All rights reserved.
//

import UIKit
import AudioToolbox

class QuestionViewController:UIViewController {
    
    
     func csvToArray () {
        if let csvPath = Bundle.main.path(forResource: "question", ofType: "csv") {
            do {
                let csvStr = try String(contentsOfFile:csvPath, encoding:String.Encoding.utf8)
                let csvArr = csvStr.components(separatedBy: .newlines)
                print(csvArr)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
   
    
    
    var questionData:QuestionData
    
    
    @IBOutlet weak var questionNoLabel: UILabel!
        //問題番号ラベル
    @IBOutlet weak var questionTextView: UITextView!
        //問題文テキストビュー

    @IBOutlet weak var answer1Button: UIButton!
        //選択肢1ボタン
    @IBOutlet weak var answer2Button: UIButton!
        //選択肢2ボタン
    @IBOutlet weak var answer3Button: UIButton!
        //選択肢3ボタン
    @IBOutlet weak var answer4Button: UIButton!
        //選択肢4ボタン
    
    @IBOutlet weak var correctImageView: UIImageView!
        //正解のイメージビュー
    @IBOutlet weak var incorrectImageView: UIImageView!
        //不正解のイメージビュー
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        csvToArray()
        
        let test = QuestionDataManager.sharedInstance
        
        test.loadQuestion()
        
        //問題文の取り出し
        guard let questionData = test.nextQuestion() else{
            return
        }
        
        
        print(questionData.question)
        
        //初期データ設定処理。前画面で設定済みのquestionDataから値を取り出す
        questionNoLabel.text = "Q.\(questionData.questionNo)"
        questionTextView.text = questionData.question
        answer1Button.setTitle(questionData.answer1,for:UIControlState.normal)
        answer2Button.setTitle(questionData.answer2,for:UIControlState.normal)
        answer3Button.setTitle(questionData.answer3,for:UIControlState.normal)
        answer4Button.setTitle(questionData.answer4,for:UIControlState.normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //選択肢1をタップ
    @IBAction func tapAnswer1Button(_ sender:Any){
        questionData.userChoiceAnswerNumber = 1  //選択した答えの番号を保存する
        goNextQuestionWithAnimation()            //次の問題に進む
    }
    //選択肢2をタップ
    @IBAction func tapAnswer2Button(_ sender:Any){
        questionData.userChoiceAnswerNumber = 2  //選択した答えの番号を保存する
        goNextQuestionWithAnimation()            //次の問題に進む
    }
    //選択肢3をタップ
    @IBAction func tapAnswer3Button(_ sender:Any){
        questionData.userChoiceAnswerNumber = 3  //選択した答えの番号を保存する
        goNextQuestionWithAnimation()            //次の問題に進む
    }
    //選択肢4をタップ
    @IBAction func tapAnswer4Button(_ sender:Any){
        questionData.userChoiceAnswerNumber = 4  //選択した答えの番号を保存する
        goNextQuestionWithAnimation()            //次の問題に進む
    }
    
    //次の問題にアニメーション付きで進む
    func goNextQuestionWithAnimation(){
        //正解しているか判定する
        if questionData.isCorrect(){
            //正解のアニメーションをしながら次の問題へ遷移する
            goNextQuestionWithAnimation()
        }else{
            //不正解のアニメーションをしながら次の問題へ遷移する
            goNextQuestionWithAnimation()
        }
    }
    
    //次の問題に正解のアニメーション付きで遷移する
    func goNextQuestionWithCorrectAnimation(){
        //正解を伝える音を鳴らす
        AudioServicesPlayAlertSound(1025)
        //アニメーションを行う
        UIView.animate(withDuration: 2.0, animations: {
            //アルファ値を1.0に変化される(初期値はstoryboardで0.0に設定済み)
            self.correctImageView.alpha = 1.0
            }){(Bool) in self.goNextQuestion()    //アニメーション完了後に次の問題に進む
        }
    }

    //次の問題に不正解のアニメーション付きで遷移する
    func goNextQuestionWithInCorrectAnimation(){
        //不正解を伝える音を鳴らす
        AudioServicesPlayAlertSound(1006)
        //アニメーションを行う
        UIView.animate(withDuration: 2.0, animations: {
            //アルファ値を1.0に変化される(初期値はstoryboardで0.0に設定済み)
            self.incorrectImageView.alpha = 1.0
            }){(Bool) in self.goNextQuestion()    //アニメーション完了後に次の問題に進む
        }
    }

    //次の問題へ遷移する
    func goNextQuestion(){
        //問題文がある場合は次の問題へ遷移する
        guard let nextQuestion = QuestionDataManager.sharedInstance.nextQuestion() else{
            //問題文がなければ結果画面へ遷移する
            //storyboradのIdentifierに設定した値(result)を指定してViewControllerを生成する
            if let resultViewController = storyboard?.instantiateViewController(withIdentifier: "result") as? ResultViewController{
                //storyboardのsegueを利用しない明示的な画面遷移処理
                present(resultViewController,animated:true,completion:nil)
            }
            return
        }
        // 問題文がある場合は次の問題へ遷移する
        // StoryboardのIdentifierに設定した値(question)を設定してViewControllerを生成する
        if let nextQuestionViewController = storyboard?.instantiateViewController(withIdentifier: "question") as? QuestionViewController{
            nextQuestionViewController.questionData = nextQuestion
            // StoryboardのSegueを利用しない明示的な画面遷移処理
            present(nextQuestionViewController, animated: true,completion: nil)
        
        
        }
    }
}
