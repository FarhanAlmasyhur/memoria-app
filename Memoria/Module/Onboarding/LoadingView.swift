//
//  LoadingView.swift
//  Memoria
//
//  Created by Muhammad Farhan Almasyhur on 25/06/23.
//

import SwiftUI

struct LoadingView: View {
    
    @State var progress: Double = 0
    
    var body: some View {
        ZStack {
            Color.blackAccent
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .center) {
                Spacer()
                Spacer()
                MemoriaLogo()
                Spacer()
                VStack {
                    CircularProgressView(progress: progress)
                        .frame(width: 32, height: 32)
                    Text("Loading...")
                        .font(.custom("Inter", fixedSize: 14))
                        .fontWeight(.regular)
                        .foregroundColor(Color(hex: "#FAFAFA"))
                }
                Spacer()
            }
        }.onAppear {
            for _ in 0..<10 {
                DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
                    progress += 0.1
                }
            }
        }.navigationBarHidden(true)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
