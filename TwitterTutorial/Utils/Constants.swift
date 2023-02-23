//
//  Constants.swift
//  TwitterTutorial
//
//  Created by Guowei Lv on 22.12.2022.
//

import Firebase

let BASE_URL = "https://twittertutorial-a28f9-default-rtdb.europe-west1.firebasedatabase.app"

let DB_REF = Database.database(
    url: BASE_URL
).reference()

let REF_USERS = DB_REF.child("users")

let STORAGE_REF = Storage.storage(url: "gs://twittertutorial-a28f9.appspot.com").reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")
