//
//  LoginViewModel.swift
//  R'n'M-test-v1
//
//  Created by Александр on 14.09.2022.
//

import Foundation

protocol LoginViewModelProtocol {
   
   var isLoginOk: Bool { get set }
   var isPasswordOk: Bool { get set }
   func loginButtonPressed(login: String?, password: String?)
}

class LoginViewModel: LoginViewModelProtocol {
   
   var isLoginOk: Bool = false
   var isPasswordOk: Bool = false
   
   func loginButtonPressed(login: String?, password: String?) {
      
      if let login = login, login.count > 4 {
         isLoginOk = true
      } else {
         isLoginOk = false
      }
      
      if let password = password, password.count > 4 {
         isPasswordOk = true
      } else {
         isPasswordOk = false
      }
   }
}
