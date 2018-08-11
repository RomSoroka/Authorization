//
//  Alert.swift
//  Alert-Refactor
//
//  Created by Sean Allen on 7/15/18.
//  Copyright © 2018 Sean Allen. All rights reserved.
//

import Foundation
import UIKit

struct Alert {
    private init() {}
    
    private static func showBasicAlert(on vc: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async { vc.present(alert, animated: true) }
    }
    
    static func showRegistratoinError(on vc: UIViewController) {
        showBasicAlert(on: vc, with: "Error", message: "Registration Error Occured")
    }
    
    static func showLoginError(on vc: UIViewController) {
        showBasicAlert(on: vc, with: "Error", message: "Login Error Occured")
    }
    
    static func showGetTextError(on vc: UIViewController) {
        showBasicAlert(on: vc, with: "Error", message: "You may have to relogin")
    }
}
