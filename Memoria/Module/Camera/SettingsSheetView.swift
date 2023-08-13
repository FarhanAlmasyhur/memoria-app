//
//  SettingsSheetView.swift
//  Memoria
//
//  Created by Muhammad Farhan Almasyhur on 13/08/23.
//

import SwiftUI
struct SettingsSheetView: View, KeyboardReadable {
    
    @ObservedObject var viewModel: CameraViewModel
    @Binding var height: CGFloat
    
    @State var text: String = ""
    
    var body: some View {
        VStack {
            TitleBar(title: "Settings")
            VStack(spacing: 20) {
                inputField(imageName: "tag", title: "Party Name", placeholder: "Enter party name", text: $text)
                inputField(imageName: "person.3", title: "Number of Guests", placeholder: "Enter number of guests", text: $text)
                inputField(imageName: "camera", title: "Photos per Person", placeholder: "Enter photos per person", text: $text)
                HStack {
                    buttonRow(imageName: "qrcode", label: "QR Code", action: {
                        withAnimation {
                            viewModel.showSettingsSheet.toggle()
                            viewModel.showShareQRSheet.toggle()
                        }
                    })
                    buttonRow(imageName: "link", label: "Direct Link", action: {
                        print("hello link")
                    })
                }
            }
            .padding()
            Spacer()
        }
        .frame(height: height)
        .padding()
        .background(Color.blackBg)
    }
}

extension SettingsSheetView {
    func TitleBar(title: String) -> some View {
        HStack {
            Spacer()
            Text(title)
                .interFont(size: 16)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            Spacer()
            Image(systemName: "xmark")
                .resizable()
                .frame(width: 10, height: 10)
                .foregroundColor(.white)
                .onTapGesture {
                    withAnimation {
                        viewModel.showSettingsSheet.toggle()
                    }
                }
        }.padding()
    }
    
    func inputField(imageName: String, title: String, placeholder: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .interFont(size: 12)
                .fontWeight(.medium)
                .foregroundColor(.white)
            
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 14)
                    .padding(5)
                    .foregroundColor(.black)
                    .animation(.default)
                    .scaleEffect(x: -1, y: 1)
                
                TextField(placeholder, text: text)
                    .font(.custom("Inter", size: 15))
                    .foregroundColor(.blackAccent)
                    .padding(7)
            }
            .background(Color.white)
            .cornerRadius(6)
        }
    }
    
    func buttonRow(imageName: String, label: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15)
                    .foregroundColor(.purpleButton)
                
                Text(label)
                    .interFont(size: 16)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.purpleButton)
            }
            .padding()
            .padding(.horizontal, 10)
            .background(Color.primaryWhite)
            .cornerRadius(6)
        }
    }
}


struct SettingsSheetView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsSheetView(viewModel: CameraViewModel(), height: .constant(200))
    }
}
