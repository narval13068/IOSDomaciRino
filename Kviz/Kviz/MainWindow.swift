//
//  MainWindow.swift
//  Kviz
//
//  Created by Rino Čala on 05/04/2019.
//  Copyright © 2019 Rino Cala. All rights reserved.
//

import UIKit

class MainWindow: UIViewController {

    @IBOutlet weak var errorlabel: UILabel!
    @IBOutlet weak var funfactlabel: UILabel!
    @IBOutlet weak var naslovlabel: UILabel!
    @IBOutlet weak var uiimageview: UIImageView!
    @IBOutlet weak var Questionview: UIView!
    var allquizzes : [Quiz?]!
    var loginwindow : LoginScreen!
    var window :UIWindow!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    @IBAction func odjavi(_ sender: Any) {
        UserDefaults.standard.setValue(nil, forKey: "providedtoken")
        if (self == window.rootViewController) {
            self.present(loginwindow, animated: false, completion: nil)
        }
        else {
            dismiss(animated: false, completion: nil)
        }
    }
    
    
    @IBAction func dohvatitapped(_ sender: Any) {
        let service = Service()
        service.fetchQuizzes(urlString: "https://iosquiz.herokuapp.com/api/quizzes")
            { (json) in
                if let json = json {
                    
                let quizzesdictionary = (json as? [String:Any])?["quizzes"] as? [[String:Any]]
                var i=0
                var arrayofquizzes = [Quiz?](repeating: nil, count: quizzesdictionary!.count)
                while i<quizzesdictionary!.count {
                    arrayofquizzes[i]=Quiz(arraydata: quizzesdictionary![i])
                    i+=1
                }
                self.allquizzes = arrayofquizzes
                    
                var numberofNBA = 0
                i=0
                    while i<self.allquizzes.count {
                        numberofNBA  = numberofNBA + (self.allquizzes[i]?.arrayquestions.map({
                            (value: Question) -> String in
                            return value.question!
                        }).filter({(ques)-> Bool in
                            return ques.contains("NBA")
                        }).count)!
                        i+=1
                    }
                
                if let ourquiz = self.allquizzes![0] {
                    if let sportimage = ourquiz.image {
                    service.fetchQuizImage(urlstring: sportimage) {
                        (image) in
                        DispatchQueue.main.async {
                            self.naslovlabel.text = ourquiz.title
                            self.uiimageview.image=image
                            self.funfactlabel.text = String(numberofNBA)
                            self.funfactlabel.isHidden=false
                            self.naslovlabel.isHidden=false
                            self.uiimageview.isHidden=false
                            
                            if ourquiz.category == Category.Sport {
                                self.naslovlabel.backgroundColor=UIColor.yellow
                                self.uiimageview.backgroundColor=UIColor.yellow
                            }
                            if ourquiz.category == Category.Science {
                                self.naslovlabel.backgroundColor=UIColor.blue
                                self.uiimageview.backgroundColor=UIColor.blue
                            }
                            if let customView = Bundle.main.loadNibNamed("QuestionView", owner: self, options: nil)?.first as? QuestionView {
                            self.Questionview.addSubview(customView)
                            customView.questionlabel.text=ourquiz.arrayquestions[0].question
                                customView.buttonA.setTitle(ourquiz.arrayquestions[0].answers?[0], for: .normal)
                                customView.buttonB.setTitle(ourquiz.arrayquestions[0].answers?[1], for: .normal)
                                customView.buttonC.setTitle(ourquiz.arrayquestions[0].answers?[2], for: .normal)
                                customView.buttonD.setTitle(ourquiz.arrayquestions[0].answers?[3], for: .normal)
                                customView.correctanswer=ourquiz.arrayquestions[0].correctanswer!
                        
                        }
                        }
                     }
                    }
                }
            }
                
            else {
                    DispatchQueue.main.async {
                  self.errorlabel.isHidden=false
                    }
                }
        }
        
        
    
    }
}
