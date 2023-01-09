//
//  LoginController.swift
//  TwitterTutorial
//
//  Created by Guowei Lv on 5.12.2022.
//

import Foundation
import UIKit

class LoginController: UIViewController {

    // MARK: - Properties
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = UIImage(named: "TwitterLogo")
        return iv
    }()

    private lazy var emailContainerView: UIView = {
        return Utilities().inputContainerView(
            withImage: UIImage(named: "ic_mail_outline_white_2x-1")!, textField: emailTextField)
    }()

    private lazy var passwordContainerView: UIView = {
        return Utilities().inputContainerView(
            withImage: UIImage(named: "ic_lock_outline_white_2x")!, textField: passwordTextField)
    }()

    private let emailTextField: UITextField = {
        let tf = Utilities().textField(withPlaceHolder: "Email")
        return tf
    }()

    private let passwordTextField: UITextField = {
        let tf = Utilities().textField(withPlaceHolder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()

    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()

    private let dontHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Don't have an accout?", " Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Selectors

    @objc func handleLogin() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        AuthService.shared.logUserIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUGG - error logging in \(error.localizedDescription)")
                return
            }
            print("DEBUGG - succesful login")
        }
    }

    @objc func handleShowSignUp() {
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }

    // MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true

        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        logoImageView.setDimensions(width: 150, height: 150)

        let stack = UIStackView(arrangedSubviews: [
            emailContainerView, passwordContainerView, loginButton,
        ])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually

        view.addSubview(stack)
        stack.anchor(
            top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
            paddingLeft: 16, paddingRight: 16)

        view.addSubview(dontHaveAccountButton)

        dontHaveAccountButton.anchor(
            left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.rightAnchor, paddingLeft: 40, paddingRight: 40)
    }

}
