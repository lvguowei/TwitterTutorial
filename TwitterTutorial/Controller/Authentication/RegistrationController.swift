//
//  RegistrationController.swift
//  TwitterTutorial
//
//  Created by Guowei Lv on 5.12.2022.
//

import Firebase
import UIKit

class RegistrationController: UIViewController {

    // MARK: - Properties

    private let imagePicker = UIImagePickerController()
    private var profileImage: UIImage?

    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleAddProfilePhoto), for: .touchUpInside)
        return button
    }()

    private lazy var emailContainerView: UIView = {
        return Utilities().inputContainerView(
            withImage: UIImage(named: "ic_mail_outline_white_2x-1")!, textField: emailTextField)
    }()

    private lazy var passwordContainerView: UIView = {
        return Utilities().inputContainerView(
            withImage: UIImage(named: "ic_lock_outline_white_2x")!, textField: passwordTextField)
    }()

    private lazy var fullNameContainerView: UIView = {
        return Utilities().inputContainerView(
            withImage: UIImage(named: "ic_person_outline_white_2x")!, textField: fullNameTextField)
    }()

    private lazy var userNameContainerView: UIView = {
        return Utilities().inputContainerView(
            withImage: UIImage(named: "ic_person_outline_white_2x")!, textField: userNameTextField)
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

    private let fullNameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceHolder: "Full Name")
        return tf
    }()

    private let userNameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceHolder: "Username")
        return tf
    }()

    private let alreadyHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Already have an accout?", " Log In")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()

    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Selectors

    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }

    @objc func handleSignUp() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullname = fullNameTextField.text else { return }
        guard let username = userNameTextField.text else { return }
        guard let profileImage = profileImage else { return }

        guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else { return }
        let fileName = NSUUID().uuidString
        let storageRef = STORAGE_PROFILE_IMAGES.child(fileName)

        storageRef.putData(imageData) { meta, error in
            storageRef.downloadURL { url, error in
                guard let profileImageUrl = url?.absoluteString else { return }

                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard let uid = result?.user.uid else { return }

                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }

                    let values = [
                        "email": email, "username": username, "fullname": fullname,
                        "profileImageUrl": profileImageUrl,
                    ]

                    REF_USERS.child(uid).updateChildValues(values) {
                        error, ref in
                        print("haha")
                    }
                }
            }
        }

    }

    @objc func handleAddProfilePhoto() {
        present(imagePicker, animated: true)
    }

    // MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .twitterBlue

        imagePicker.delegate = self
        imagePicker.allowsEditing = true

        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        plusPhotoButton.setDimensions(width: 128, height: 128)

        let stack = UIStackView(arrangedSubviews: [
            emailContainerView, passwordContainerView, fullNameContainerView, userNameContainerView,
            signUpButton,
        ])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually

        view.addSubview(stack)
        stack.anchor(
            top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
            paddingLeft: 32, paddingRight: 32)

        view.addSubview(alreadyHaveAccountButton)

        alreadyHaveAccountButton.anchor(
            left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.rightAnchor, paddingLeft: 40, paddingRight: 40)
    }
}

// MARK: - UIImagePickerControllerDelegate
extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }

        plusPhotoButton.layer.cornerRadius = 128 / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.imageView?.contentMode = .scaleAspectFill
        plusPhotoButton.imageView?.clipsToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 3
        self.plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)

        self.profileImage = profileImage
        dismiss(animated: true)
    }
}
