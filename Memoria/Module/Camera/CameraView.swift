//
//  CameraView.swift
//  Memoria
//
//  Created by Muhammad Farhan Almasyhur on 17/07/23.
//

import SwiftUI

struct CameraView: View {
    
    @StateObject var camera = CameraModel()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .top) {
                    CameraPreview(camera: camera)
                        .frame(height: geometry.size.height * 0.8)
                        .cornerRadius(24)
                    
                    HStack {
                        Text("25 June")
                            .font(.custom("Inter", fixedSize: 12))
                            .fontWeight(.semibold)
                            .foregroundColor(.softWhite)
                    }
                    .padding()
                    .background(Color.black.opacity(0.4))
                    .cornerRadius(6)
                    .padding(.top, 20)
                }
                HStack {
                    Text("Back")
                    Text("10 Shots Remaining")
                    Text("Settings")
                }
            }
        }.navigationBarHidden(true)
         .background(Color.blackAccent)
         .onAppear {
             camera.checkAuthorizationStatus()
         }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
