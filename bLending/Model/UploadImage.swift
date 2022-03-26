//
//  UploadImage.swift
//  bLending
//
//  Created by Sanghyeon Lee on 2022/03/24.
//

import SwiftUI
import Firebase
import FirebaseStorage
import KakaoSDKUser

//func UploadImage(imageData: [Data], path: String, completion: @escaping (String) -> ()) {
func UploadImage(imageData: [UIImage], path: String, completion: @escaping (String) -> ()) {    // ToDo: Image 압축해서 하나의 파일로 만들어서 upload?
    let storage = Storage.storage().reference()
    //let uid = Auth.auth().currentUser!.uid
    
    UserApi.shared.me() { (user, error) in
        if let error = error {
            print(error)
        } else {
            print("me() success.")
            
            let uid = user!.id
            
            for image_data in imageData {
                guard let data = image_data.pngData() else { return }
                storage.child(path).child(String(uid!)).putData(data, metadata: nil) { (_, err) in
                //storage.child(path).putData(data, metadata: nil) { (_, err) in
                    if err != nil {
                        completion("")
                        return
                    }
                    
                    //storage.child(path).child(uid).downloadURL { (url, err) in
                    storage.child(path).downloadURL { (url, err) in
                        if err != nil {
                            completion("")
                            return
                        }
                        
                        completion("\(url!)")
                    }
                }
            }
            
            _ = user
        }
    }

    
}
