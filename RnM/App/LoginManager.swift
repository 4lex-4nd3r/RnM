//
//  LoginManager.swift
//  R'n'M-test-v1
//
//  Created by Александр on 14.09.2022.
//

import UIKit

class LoginManager {
   
   static let shared = LoginManager()
   private init() {}
   
   func getRootVC() -> UIViewController {

      let defaults = UserDefaults.standard
      if let isLogged = defaults.object(forKey: UserDefaultsKeys.loginKey.rawValue) as? String {
         switch isLogged {
         case UserDefaultsKeys.loginKey.rawValue:
            let nav = UINavigationController(rootViewController: ListViewController())
            return nav
         default:
            let nav = UINavigationController(rootViewController: LoginViewController())
            return nav
         }
      } else {
         let nav = UINavigationController(rootViewController: LoginViewController())
         return nav
      }
   }
}
