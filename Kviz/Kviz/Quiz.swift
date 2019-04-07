//
//  File.swift
//  Kviz
//
//  Created by Rino Čala on 05/04/2019.
//  Copyright © 2019 Rino Cala. All rights reserved.
//

import UIKit

class Quiz {
    
    var id : String?
    var title : String?
    var description : String?
    var category : Category?
    var level : String?
    var image : String?
    var arrayquestions : [Question]!
    
    init?(arraydata : [String:Any]) {
            let id = arraydata["id"] as? String
            let title = arraydata["title"] as? String
            let description = arraydata["description"] as? String
            let category = arraydata["category"] as? String
            let level = arraydata["level"] as? String
            let image = "https://www.fullersports.com.au/files/media/thumbcache/185/363/c46/sportsdevelopment_thumbnail.jpg"
            let questions = arraydata["questions"] as! [[String: Any]]
            
            self.id = id
            self.title = title
            self.description = description
            self.level = level
            self.image = image
            var i=0
            var arraycreate : [Question?] = [Question?](repeating: nil, count: questions.count)
            while i<questions.count {
                if let ques = Question(dictionary: questions[i]) {
                    arraycreate[i] = ques
                }
                i+=1
            }
            self.arrayquestions = arraycreate as? [Question]
            if category == "SPORTS" {
                self.category=Category.Sport
            }
            else {
                self.category=Category.Science
            }
            
        }
        
        
}
    


