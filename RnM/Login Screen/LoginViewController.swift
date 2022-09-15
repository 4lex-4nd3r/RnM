//
//  LoginViewController.swift
//  R'n'M-test-v1
//
//  Created by Александр on 14.09.2022.
//

import UIKit

class LoginViewController : UIViewController {
   
   // MARK: - Properties
   
   private let loginTextField: UITextField = {
      let tf = UITextField()
      tf.text = "12345"
      tf.backgroundColor = .systemGray6
      tf.font = UIFont.systemFont(ofSize: 18)
      tf.placeholder = "введите логин"
      tf.textAlignment = .center
      tf.autocorrectionType = .no
      tf.autocapitalizationType = .none
      tf.clearButtonMode = .always
      
      tf.layer.masksToBounds = true
      tf.layer.cornerRadius = 10
      tf.borderStyle = .none
      
      tf.returnKeyType = .next
      tf.translatesAutoresizingMaskIntoConstraints = false
      return tf
   }()
   
   private let passwordTextField: UITextField = {
      let tf = UITextField()
      tf.text = "12345"
      
      tf.backgroundColor = .systemGray6
      tf.font = UIFont.systemFont(ofSize: 18)
      tf.placeholder = "введите пароль"
      tf.textAlignment = .center
      
      tf.autocorrectionType = .no
      tf.autocapitalizationType = .none
      tf.clearButtonMode = .always
      tf.layer.masksToBounds = true
      tf.layer.cornerRadius = 10
      tf.borderStyle = .none
      
      tf.borderStyle = .none
      tf.returnKeyType = .done
      tf.translatesAutoresizingMaskIntoConstraints = false
      return tf
   }()
   
   private lazy var loginButton: UIButton = {
      let button = UIButton()
      button.setTitle("войти в аккаунт", for: .normal)
      button.setTitleColor(UIColor.white, for: .normal)
      button.backgroundColor = .systemBlue
      button.layer.cornerRadius = 5
      button.layer.shadowColor = UIColor.black.cgColor
      button.layer.shadowRadius = 4
      button.layer.shadowOpacity = 0.2
      button.layer.shadowOffset = CGSize(width: 0, height: 4)
      button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
      button.translatesAutoresizingMaskIntoConstraints = false
      return button
   }()
   
   private let logoImageView: UIImageView = {
      let imageView = UIImageView()
      imageView.image =  UIImage(named: "logo")
      imageView.contentMode = .scaleAspectFill
      imageView.translatesAutoresizingMaskIntoConstraints = false
      return imageView
   }()
   
   private var loginStack = UIStackView()
   
   private var viewModel: LoginViewModelProtocol!
   
   // MARK: - Lifecycle
   
   override func viewDidLoad() {
      super.viewDidLoad()
      viewModel = LoginViewModel()
      setupViews()
      setConstraints()
      setDelegates()
      setupKeyboardHidesOnTap()
   }
   
   //MARK: - Setups
   
   private func setupViews() {
      view.backgroundColor = .systemBackground
      view.addSubview(logoImageView)
      loginStack = UIStackView(arrangedSubviews: [loginTextField,
                                                  passwordTextField,
                                                  loginButton])
      loginStack.axis = .vertical
      loginStack.spacing = 20
      loginStack.distribution = .fillEqually
      loginStack.translatesAutoresizingMaskIntoConstraints = false
      
      view.addSubview(loginStack)
   }
   
   private func setDelegates() {
      loginTextField.delegate = self
      passwordTextField.delegate = self
   }
   
   //MARK: - Selectors
   
   @objc private func loginButtonTapped() {
      
      guard let loginViewModel = viewModel else { return }
      loginViewModel.loginButtonPressed(login: loginTextField.text,
                                        password: passwordTextField.text)
      
      guard loginViewModel.isLoginOk else {
         alertOk(title: "Ошибка", message: "Неверный login")
         return
      }
      guard loginViewModel.isPasswordOk else {
         alertOk(title: "Ошибка", message: "Неверный password")
         return
      }

      UserDefaults.standard.set(Login.login.rawValue, forKey: UserDefaultsKeys.loginKey.rawValue)
      
      let nav = UINavigationController(rootViewController: ListViewController())
      guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
      
      window.rootViewController = nav
      
      UIView.transition(with: window, duration: 1, options: [.transitionCrossDissolve], animations: {}, completion: nil)
   }
   
   //MARK: - Constraints
   
   private func setConstraints() {
      
      NSLayoutConstraint.activate([
         logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
         logoImageView.heightAnchor.constraint(equalToConstant: 60),
         logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
         logoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
      ])
      
      NSLayoutConstraint.activate([
         loginStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
         loginStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
         loginStack.bottomAnchor.constraint(equalTo: logoImageView.topAnchor, constant: -40),
      ])
   }
}

extension LoginViewController: UITextFieldDelegate {
   
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      if textField == loginTextField {
         passwordTextField.becomeFirstResponder()
      } else if textField == passwordTextField {
         passwordTextField.resignFirstResponder()
      }
      return true
   }
}
