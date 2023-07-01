//
//  LoadingView.swift
//  Memoria
//
//  Created by Muhammad Farhan Almasyhur on 25/06/23.
//

import SwiftUI
import NavigationBackport

struct LoadingView: View {
    
    @StateObject private var appStateNavigation = AppStateNavigation.shared
    @State private var progress: Double = 0
    @State private var goToMainView: Bool = false

    var body: some View {
        ZStack {
            Color.blackAccent
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Spacer()
                MemoriaLogo()
                Spacer()
                loadingView
                Spacer()
            }
        }
        .onAppear {
            startProgressAnimation()
        }
        .navigationBarHidden(true)
        .nbNavigationDestination(isPresented: $goToMainView) {
            MainView()
        }
    }

    private var loadingView: some View {
        VStack {
            CircularProgressView(progress: progress)
                .frame(width: 32, height: 32)
            Text("Loading...")
                .font(.custom("Inter", fixedSize: 14))
                .fontWeight(.regular)
                .foregroundColor(Color(hex: "#FAFAFA"))
        }
    }

    private func startProgressAnimation() {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            animateProgress()
        }
    }

    private func animateProgress() {
        if progress >= 1 {
            goToMainView = true
            return
        }
        
        withAnimation(.easeInOut(duration: 0.1)) {
            progress += 0.1
        }
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.1) {
            animateProgress()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
