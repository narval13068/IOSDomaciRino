//
//  LoginScreen.swift
//  Kviz
//
//  Created by Rino Čala on 07/04/2019.
//  Copyright © 2019 Rino Cala. All rights reserved.
//

import UIKit

class LoginScreen: UIViewController ,UITextFieldDelegate{
    
    @IBOutlet weak var passwordfield: UITextField!
    @IBOutlet weak var errorlabel: UILabel!
    @IBOutlet weak var usernamefield: UITextField!
    var mainwindow : MainWindow! = nil
    var window : UIWindow!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewtapped)))
        if UserDefaults.standard.value(forKey: "providedtoken") != nil {
            self.present(mainwindow, animated: false, completion: nil)
        }
        passwordfield.delegate=self
        usernamefield.delegate=self
    }
    
    
    @IBAction func loginbuttonclick(_ sender: Any) {
        errorlabel.isHidden=true
        let url = URL(string: "https://iosquiz.herokuapp.com/api/session")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let username : String = usernamefield.text!.trimmingCharacters(in: .whitespaces)
        let password : String = passwordfield.text!.trimmingCharacters(in: .whitespaces)
        let parameters: [String: Any] = [
            "username": username,
            "password": password
        ]
        request.httpBody = parameters.percentEscaped().data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {
                    DispatchQueue.main.async {
                        self.errorlabel.isHidden=false
                    }
                    return
            }
            
            guard (200 ... 299) ~= response.statusCode else {
                DispatchQueue.main.async {
                        self.errorlabel.isHidden=false
                }
                return
            }
            
            let token = String(data: data, encoding: .utf8)
            UserDefaults.standard.set(token, forKey: "providedtoken")
            DispatchQueue.main.async {
                if self.window.rootViewController == self {
                    self.present(self.mainwindow, animated: false, completion: nil)
                }
                else {
                    self.dismiss(animated: false, completion: nil)
                }
            }
        }
        
        task.resume()
    }
    
    @objc func viewtapped() {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    
    
    
}






















extension Dictionary {
    func percentEscaped() -> String {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
            }
            .joined(separator: "&")
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
