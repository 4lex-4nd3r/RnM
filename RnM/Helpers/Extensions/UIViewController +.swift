//
//  UIViewController +.swift
//  R'n'M-test-v1
//
//  Created by Александр on 14.09.2022.
//

import UIKit

extension UIViewController {
   
   //MARK: - Hide Keyboard
   
   func setupKeyboardHidesOnTap() {
      let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
      tap.cancelsTouchesInView = true
      view.addGestureRecognizer(tap)
   }
   @objc private func dismissKeyboard() {
      view.endEditing(true)
   }
   
   //MARK: - Simple Alert
   
   func alertOk(title: String, message: String) {
      let alertController = UIAlertController(title: title,
                                              message: message,
                                              preferredStyle: .alert)
      let ok = UIAlertAction(title: "ok", style: .default)
      alertController.addAction(ok)
      present(alertController, animated: true)
   }
}
