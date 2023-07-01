//
//  HomeView.swift
//  Memoria
//
//  Created by Muhammad Farhan Almasyhur on 26/06/23.
//

import SwiftUI
import CodeScanner

struct HomeView: View {
    
    @StateObject var appStateNavigation = AppStateNavigation.shared
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 0) {
                    ZStack(alignment: .center) {
                        Image("img_scanqr")
                            .resizable()
                            .scaledToFit()
                            .padding(.top, 30)
                        VStack {
                            Image("img_phone_scanqr")
                                .resizable()
                                .scaledToFit()
                                .frame(height: geometry.size.height * 0.4)
                            Text("With a ***QR code from Memoria***, guests can conveniently capture their favorite moments.")
                                .font(.custom("Inter", fixedSize: 14))
                                .fontWeight(.regular)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .padding(.top, 10)
                        }
                    }.frame(width: geometry.size.width * 0.9)
                    .padding(.bottom, 5)
                    LargeButtonImage(title: "Join by Scan QR", image: "qrcode", backgroundColor: .purpleButton, foregroundColor: .white) {
                        withAnimation(.spring()) {
                            appStateNavigation.showJoinByQR = true
                        }
                       
                    }
                    
                    LargeButtonImage(title: "Join by Code", image: "123.rectangle", backgroundColor: Color(hex: "EEF2FF"), foregroundColor: .purpleButton) {
                        withAnimation(.interactiveSpring()) {
                            appStateNavigation.showJoinByCode = true
                        }
                        
                    }
                    
                }
            }.frame(width: geometry.size.width)
             .frame(minHeight: geometry.size.height)
        }   .background(Color.blackAccent)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
