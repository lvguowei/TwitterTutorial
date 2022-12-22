//
//  AuthService.swift
//  TwitterTutorial
//
//  Created by Guowei Lv on 22.12.2022.
//

import Firebase
import UIKit

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    static let shared = AuthService()

    func registerUser(
        credentials: AuthCredentials, completion: @escaping (Error?, DatabaseReference) -> Void
    ) {
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else {
            return
        }
        let fileName = NSUUID().uuidString
        let storageRef = STORAGE_PROFILE_IMAGES.child(fileName)

        storageRef.putData(imageData) { meta, error in
            storageRef.downloadURL { url, error in
                guard let profileImageUrl = url?.absoluteString else { return }

                Auth.auth().createUser(withEmail: credentials.email, password: credentials.password)
                { result, error in
                    guard let uid = result?.user.uid else { return }

                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }

                    let values = [
                        "email": credentials.email, "username": credentials.username,
                        "fullname": credentials.fullname,
                        "profileImageUrl": profileImageUrl,
                    ]

                    REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
                }
            }
        }
    }
}
