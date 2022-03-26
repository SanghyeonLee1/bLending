//
//  ContentView.swift
//  bLending
//
//  Created by Sanghyeon Lee on 2022/02/13.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("login_status") var login_status = false
    var body: some View {
        if login_status {
            HomeView()
        } else {
            KakaoLoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
