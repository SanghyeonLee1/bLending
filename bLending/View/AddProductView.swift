//
//  AddProductView.swift
//  bLending
//
//  Created by Sanghyeon Lee on 2022/03/24.
//

import SwiftUI
import PhotosUI

struct AddProductView: View {
    @StateObject var addProductVM = AddProductViewModel()
    
    @State private var isPresented: Bool = false
    //@State var pickerResult: [UIImage] = []
    @State var pickerResult: [UIImage] = []
    //@State var pickerResult = Data(count: 0)
    var config: PHPickerConfiguration {
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        
        config.filter = .images //videos, livePhotos
        config.selectionLimit = 5
        return config
    }
    
//    @State var product_name: String = ""
//    @State var product_description_1: String = ""
//    @State var product_description_2: String = ""
//    @State var product_description_3: String = ""
//    @State var product_price: String = ""
//    @State var product_price_unit: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Button(action: {
                    pickerResult.removeAll()
                    //addProductVM.product_image.removeAll()
                }, label: {
                    Text("Remove all")
                        .foregroundColor(.red)
                        .padding()
                })
                
                Button(action: {
                    self.isPresented.toggle()
                }, label: {
                    Text("Add image")
                        .padding()
                }).sheet(isPresented: $isPresented, content: {
                    ImagePicker(configuration: self.config, pickerResult: $addProductVM.product_image, isPresented: $isPresented)
                    //ImagePicker(configuration: self.config, pickerResult: $pickerResult, isPresented: $isPresented)
                })
            }

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ImagePageView(imageArray: addProductVM.product_image)
                    //ImagePageView(imageArray: pickerResult)
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: 250, alignment: .center)
            
            HStack {
                TextField("Enter product name", text: $addProductVM.product_name)
                    .frame(width: 200)
                    .border(Color(UIColor.separator))
                    .padding(.trailing)
                
                TextField("Price", text: $addProductVM.product_price)
                    .border(Color(UIColor.separator))
                    .keyboardType(.numberPad)
                
                Picker("Price unit", selection: $addProductVM.product_price_unit) {
                    Text("₩ / Day").tag("₩ / Day")
                    Text("₩ / Week").tag("₩ / Week")
                    Text("₩ / Mon").tag("₩ / Mon")
                }
            }
            .frame(width:UIScreen.main.bounds.width - 20)
            
            TextEditor(text: $addProductVM.product_description_1)
                .frame(width: UIScreen.main.bounds.width - 20, height: 30)
                .border(Color(UIColor.separator))
                .lineLimit(1)
            
            TextEditor(text: $addProductVM.product_description_2)
                .frame(width: UIScreen.main.bounds.width - 20, height: 30)
                .border(Color(UIColor.separator))
                .lineLimit(1)
            
            TextEditor(text: $addProductVM.product_description_3)
                .frame(width: UIScreen.main.bounds.width - 20, height: 60)
                .border(Color(UIColor.separator))
                .lineLimit(2)
            
            Spacer()
            
            Button(action: {
                addProductVM.upload()
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.orange)
                        .frame(width: UIScreen.main.bounds.width - 20, height: 50)
                    
                    Text("Upload")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
            })
        }
    }
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView()
    }
}

struct ImagePageView: View {
    let imageArray: [UIImage]
    
    var body: some View {
        if (imageArray.count > 0) {
            TabView {
                ForEach(imageArray, id: \.self) { image in
                    ZStack {
                        Image.init(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width - 20, height: 250)
                            .clipped()
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: 250)
            .tabViewStyle(PageTabViewStyle())
        }
    }
}
