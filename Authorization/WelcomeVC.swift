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
        Token.current.token = nil
    }
}
