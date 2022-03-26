//
//  HomeView.swift
//  bLending
//
//  Created by Sanghyeon Lee on 2022/03/24.
//

import SwiftUI

struct HomeView: View {
    @State private var isPresented: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    
                }, label: {
                    Text("Log out")
                        .padding()
                })
                
                Spacer()
                
                Button(action: {
                    self.isPresented.toggle()
                }, label: {
                    Image(systemName: "plus")
                        .font(.system(size: 30, weight: .bold))
                        .padding()
                }).sheet(isPresented: $isPresented, content: {
                    AddProductView()
                })
            }
            
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
