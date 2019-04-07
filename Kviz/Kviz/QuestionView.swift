//
//  QuestionView.swift
//  Kviz
//
//  Created by Rino Čala on 06/04/2019.
//  Copyright © 2019 Rino Cala. All rights reserved.
//


import UIKit

class QuestionView: UIView {
    
    @IBOutlet weak var questionlabel: UILabel!
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonB: UIButton!
    @IBOutlet weak var buttonC: UIButton!
    @IBOutlet weak var buttonD: UIButton!
    var correctanswer : Int!
    
    
    @IBAction func buttonA(_ sender: Any) {
        if (correctanswer==0) {
            buttonA.backgroundColor=UIColor.green
        }
        else {
            buttonA.backgroundColor=UIColor.red
        }
    }
    
    @IBAction func buttonB(_ sender: Any) {
        if (correctanswer==1) {
            buttonB.backgroundColor=UIColor.green
        }
        else {
            buttonB.backgroundColor=UIColor.red
        }
    }
    
    @IBAction func buttonC(_ sender: Any) {
        if (correctanswer==2) {
            buttonC.backgroundColor=UIColor.green
        }
        else {
            buttonC.backgroundColor=UIColor.red
        }
    }
    
    @IBAction func buttonD(_ sender: Any) {
        if (correctanswer==3) {
            buttonD.backgroundColor=UIColor.green
        }
        else {
            buttonD.backgroundColor=UIColor.red
        }
    }
}
