//
//  KakaoLoginViewModel.swift
//  bLending
//
//  Created by Sanghyeon Lee on 2022/02/17.
//

import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import SwiftUI

class KakaoLoginViewModel: ObservableObject {
    var login_availabe = false
    @AppStorage("login_status") var login_status = false
    
    func kakaoAvailable() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("Login with KakaoTalk() success.")
                    
                    self.login_availabe = true
                    _ = oauthToken
                }
            }
        }
    }
    
    func kakaoLogin() {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("login with Kakao Account() success.")
                
                self.login_status = true
                
                _ = oauthToken
            }
        }
    }
    
    func kakaoLogout() {
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            }
            else {
                self.login_status = false
                print("logout() success.")
            }
        }
    }
}
