//
//  KakaoLoginView.swift
//  bLending
//
//  Created by Sanghyeon Lee on 2022/03/24.
//

import SwiftUI

struct KakaoLoginView: View {
    @StateObject var kakaoLogin = KakaoLoginViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Logo Image")
            
            Spacer()
            
            Button(action: {
                //kakaoLogin.kakaoAvailable()
                //if kakaoLogin.login_available {
                kakaoLogin.kakaoLogin()
                //}
                
            }, label: {
                Image("kakao_login_large_wide")
                    .resizable()
                    .scaledToFit()
                    .padding()
            })
        }
    }
}

struct KakaoLoginView_Previews: PreviewProvider {
    static var previews: some View {
        KakaoLoginView()
    }
}
