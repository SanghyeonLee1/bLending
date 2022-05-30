//
//  AddProductViewModel.swift
//  bLending
//
//  Created by Sanghyeon Lee on 2022/03/24.
//

import SwiftUI
import Firebase
//import simd
import KakaoSDKUser

class AddProductViewModel: ObservableObject {
    @Published var product_name = ""
    @Published var product_price = ""
    @Published var product_price_unit = ""
    @Published var product_description_1 = ""
    @Published var product_description_2 = ""
    @Published var product_description_3 = ""
    @Published var product_image: [UIImage] = []
    //@Published var product_image = Data(count: 0)
    
    @Published var isLoading = false
    @AppStorage("current_status") var status = false
    
    let ref = Firestore.firestore()
    
    func upload() {
        isLoading = true
        
        //let uid = Auth.auth().currentUser!.uid
        
        UserApi.shared.me() { (user, error) in
            if let error = error {
                print(error)
            } else {
                print("me() success.")
                
                let uid = user!.id
                print("uid is: \(uid)")

                //user.id != nil ? String(user!.id!) : ""
                
                UploadImage(imageData: self.product_image, path: "product_photos/" + String(uid!)) { (url) in
                    self.ref.collection("Products").document().setData([
                    //self.ref.collection("Products").document(uid).setData([
                        "uid" : uid,
                        "imageUrl" : url,
                        "productName" : self.product_name,
                        "productPrice" : self.product_price,
                        "productPriceUnit" : self.product_price_unit,
                        "productDescription1" : self.product_description_1,
                        "productDescription2" : self.product_description_2,
                        "productDescription3" : self.product_description_3,
                        "dateCreated" : Date()
                    ]) { (err) in
                        if err != nil {
                            self.isLoading = false
                            return
                        }
                        
                        self.isLoading = false
                        self.status = true
                    }
                }
                
                _ = user
            }
        }
        
//        UploadImage(imageData: product_image, path: "product_photos") { (url) in
//            self.ref.collection("Products").document().setData([
//            //self.ref.collection("Products").document(uid).setData([
//                //"uid" : uid,
//                "imageUrl" : url
////                "productName" : self.product_name,
////                "productPrice" : self.product_price,
////                "productPriceUnit" : self.product_price_unit,
////                "productDescription1" : self.product_description_1,
////                "productDescription2" : self.product_description_2,
////                "productDescription3" : self.product_description_3,
////                "dateCreated" : Date()
//            ]) { (err) in
//                if err != nil {
//                    self.isLoading = false
//                    return
//                }
//
//                self.isLoading = false
//                self.status = true
//            }
//        }
    }
}
