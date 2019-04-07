//
//  File.swift
//  Kviz
//
//  Created by Rino Čala on 05/04/2019.
//  Copyright © 2019 Rino Cala. All rights reserved.
//
import UIKit

class Question {
    
    var id : String?
    var question : String?
    var answers : [String]?
    var correctanswer : Int?
    
    init?(dictionary : [String: Any]) {
         let id = dictionary["id"] as? String
        let question = dictionary["question"]  as? String
        let answers = dictionary["answers"]  as? [String]
        let correctanswer = dictionary["correct_answer"] as? Int
            
            self.id = id
            self.question = question
            self.answers = answers
            self.correctanswer = correctanswer
            
        }
    
}
