//
//  RegisterViewController.swift
//  Authorization
//
//  Created by Рома Сорока on 11.08.2018.
//  Copyright © 2018 Рома Сорока. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
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
        nameTextField.text = "newname22222"
        emailTextField.text = "emailharfreha@gmail.com"
        passwordTextField.text = "1232g4f456789"
        registerPressed(nil)
        #endif
    }
    
    @IBAction func registerPressed(_ sender: Any?) {
        guard let name = nameTextField.text,
              let email = emailTextField.text,
              let password = passwordTextField.text
            else {
                print("At least one text field is empty")
                return
        }
        
        let request = ServerDefaults.shared.registerRequest(name: name,
                                                            email: email,
                                                            password: password)
        
        let task = urlSession.dataTask(with: request) { (data, responce, error) in
            print(String.init(data: data!, encoding: String.Encoding.utf8)!)

            guard let httpResp = responce as? HTTPURLResponse,
                httpResp.statusCode == 200 else {
                    Alert.showRegistratoinError(on: self)
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
