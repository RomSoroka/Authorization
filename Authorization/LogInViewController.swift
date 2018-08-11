//
//  LogInViewController.swift
//  Authorization
//
//  Created by Рома Сорока on 11.08.2018.
//  Copyright © 2018 Рома Сорока. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let urlSession = URLSession.shared
    let decoder: JSONDecoder = {
        let dec = JSONDecoder()
        dec.keyDecodingStrategy = .convertFromSnakeCase
        return dec
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        #if DEBUG
        emailTextField.text = "emailharfreha@gmail.com"
        passwordTextField.text = "1232g4f456789"
        logInPressed(nil)
        #endif
    }
    
    @IBAction func logInPressed(_ sender: Any?) {
        guard let email = emailTextField.text,
              let passoword = passwordTextField.text
            else { return }
        
        let request = ServerDefaults.shared.loginRequest(email: email, password: passoword)
        let task = urlSession.dataTask(with: request) { (data, responce, error) in
            guard let httpResp = responce as? HTTPURLResponse,
                httpResp.statusCode == 200
                else {
                    Alert.showLoginError(on: self)
                    return
            }
            Token.current.token = try! self.decoder.decode(SignUPResonce.self, from: data!).accessToken
            print(Token.current.token!)
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "goToCharacterTable", sender: nil)
            }
            
        }
        task.resume()
    }
}
