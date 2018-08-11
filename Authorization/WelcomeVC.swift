//
//  Welcome.swift
//  Authorization
//
//  Created by Рома Сорока on 12.08.2018.
//  Copyright © 2018 Рома Сорока. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if Token.current.token != nil {
            performSegue(withIdentifier: "goToCharacterTable", sender: nil)
        }
    }
    
    @IBAction func signOut(sender: UIStoryboardSegue) {
        URLSession.shared.dataTask(with: ServerDefaults.shared.logoutRequest()) { (data, responce, error) in
            print((responce as! HTTPURLResponse).statusCode)
            print(String(data: data!, encoding: .utf8)!)
        }.resume()
        Token.current.token = nil
    }
}
