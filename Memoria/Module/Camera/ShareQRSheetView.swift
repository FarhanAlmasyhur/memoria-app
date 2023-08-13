//
//  ShareQRSheetView.swift
//  Memoria
//
//  Created by Muhammad Farhan Almasyhur on 13/08/23.
//

import SwiftUI

struct ShareQRSheetView: View {
    
    @ObservedObject var viewModel: CameraViewModel
    
    var body: some View {
        VStack {
            TitleBar(title: "Share QR Code")
            Text("Capture your favorite memories together!")
                .interFont(size: 12)
                .foregroundColor(.white)
            Image(systemName: "qrcode")
                .resizable()
                .foregroundColor(.black)
                .frame(width: 160, height: 160)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .padding(.vertical, 15)
            
            Text("Bella’s Wedding Party")
                .interFont(size: 16)
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .padding(.vertical, 5)
            HStack {
                Text("Party code: 123456")
                    .interFont(size: 12)
                    .foregroundColor(.white)
                    
                Image(systemName: "square.on.square")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
                
            }.padding(.vertical, 5)
            
            LargeButton(title: "Share", backgroundColor: .purpleButton, foregroundColor: .whiteAccent, action: actionSheet)
            
            buttonRow(imageName: "link", label: "Direct Link") {
                
            }.padding(.horizontal, 20)
            
            
            Spacer()
        }
        .padding()
        .background(Color.blackBg)
    }
    
    private func TitleBar(title: String) -> some View {
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
                        viewModel.showShareQRSheet.toggle()
                    }
                }
        }.padding()
    }
    
    func actionSheet() {
        guard let urlShare = URL(string: "https://github.com/FarhanAlmasyhur/") else { return }
        let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }
    
    private func buttonRow(imageName: String, label: String, action: @escaping () -> Void) -> some View {
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
                    .foregroundColor(.purpleButton)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .padding(.horizontal, 10)
            .background(Color.primaryWhite)
            .cornerRadius(6)
        }
    }
    
    
}

struct ShareQRSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ShareQRSheetView(viewModel: CameraViewModel())
    }
}
