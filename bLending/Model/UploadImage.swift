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
    
    UserApi.shared.me() { (user, error) in
        if let error = error {
            print(error)
        } else {
            print("me() success.")
            
            let uid = user!.id
            
            var i: Int
            i = 0
            
            for image_data in imageData {
                guard let data = image_data.pngData() else { return }
                //storage.child(path).child(String(uid!)).putData(image_data, metadata: nil) { (_, err) in
                storage.child(path).child(String(i)).putData(data, metadata: nil) { (_, err) in
                    if err != nil {
                        completion("")
                        return
                    }
                    
                    ////storage.child(path).child(String(uid!)).downloadURL { (url, err) in
                    storage.child(path).child(String(i)).downloadURL { (url, err) in
                        if err != nil {
                            completion("")
                            return
                        }
                        print("url is: \(url)")
                        completion("\(url!)")
                    }
                }
                i += 1
            }
            
            _ = user
        }
    }

    
}
