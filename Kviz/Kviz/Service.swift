//
//  File.swift
//  Kviz
//
//  Created by Rino Čala on 05/04/2019.
//  Copyright © 2019 Rino Cala. All rights reserved.
//
import UIKit

class Service {
    func fetchQuizzes(urlString: String, completion: @escaping ((Any?) -> Void)) {
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.addValue("225b3ddf80msha350534f81c8c4cp1c0858jsn2a5d1107aad8", forHTTPHeaderField: "X-RapidAPI-Key")
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        completion(json)
                    } catch {
                        completion(nil)
                    }
                    
                    
                } else {
                    completion(nil)
                }
            }
            dataTask.resume()
        } else {
            completion(nil)
        }
        
    }
    
    
    func fetchQuizImage(urlstring: String, completion: @escaping ((UIImage?) -> Void)){
        if let url = URL(string: urlstring) {
            let request = URLRequest(url: url)
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    let image = UIImage(data: data)
                    completion(image)
                } else {
                    completion(nil)
                }
            }
            dataTask.resume()
        } else {
            completion(nil)
        }
    }
    
}
