//
//  WelcomeView.swift
//  Memoria
//
//  Created by Muhammad Farhan Almasyhur on 25/06/23.
//

import SwiftUI
import NavigationBackport

struct WelcomeView: View {
    
    @StateObject var appStateNavigation = AppStateNavigation.shared
    
    var body: some View {
        NBNavigationStack(path: $appStateNavigation.path, root: {
            ZStack {
                Image("img_welcome")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .blur(radius: 5)
                    .scaledToFill()
                    .padding(-20)
                VStack {
                    Image("img_phone")
                    MemoriaLogo()
                    Text("See memories through\ndifferent perspectives")
                        .font(.custom("Inter", fixedSize: 16))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(.top, 10)
                    LargeButton(title: "Get Started →", backgroundColor: .purpleButton, foregroundColor: .white) {
                        appStateNavigation.push(to: Screen.onboarding)
                    }
                }
            }.nbNavigationDestination(for: Screen.self) { screen in
                switch screen {
                case .onboarding:
                    OnboardingView()
                case .loading:
                    LoadingView()
                }
            }
        })
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
