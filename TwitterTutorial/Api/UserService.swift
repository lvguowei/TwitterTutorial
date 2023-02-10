//
//  UserService.swift
//  TwitterTutorial
//
//  Created by Guowei Lv on 9.1.2023.
//

import Firebase

struct UserService {
    static let shared = UserService()

    func fetchUser(completion: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            let user = User(uid: uid, dictionary: dictionary)
            completion(user)
        }
    }
}
