//
//  OnboardingView.swift
//  Memoria
//
//  Created by Muhammad Farhan Almasyhur on 25/06/23.
//

import SwiftUI

struct OnboardingView: View {
    
    @State private var fullname: String = ""
    @State private var username: String = ""
    @State private var textFieldContainsSymbol: Bool = false

    @StateObject private var appStateNavigation = AppStateNavigation.shared

    var body: some View {
        ZStack {
            Color.blackAccent
                .edgesIgnoringSafeArea(.all)
            VStack {
                inputField(label: "Full Name", systemImageName: "person", text: $fullname)
                
                inputField(label: "Username", systemImageName: "at", text: $username)
                if textFieldContainsSymbol {
                    HStack {
                        Text("Only alphabets and numerals are allowed")
                            .font(.custom("Inter", fixedSize: 12))
                            .foregroundColor(.red)
                            .fontWeight(.medium)
                            .padding(.leading, 20)
                        Spacer()
                    }
                    
                }
                
                Text("You cannot change your username after sign up. Pick a good one!")
                    .font(.custom("Inter", fixedSize: 14))
                    .fontWeight(.semibold)
                    .foregroundColor(.whiteAccent)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                    .padding(.horizontal, 20)
                
                LargeButton(title: "Continue →", backgroundColor: .purpleButton, foregroundColor: .white) {
                    if containsSymbol(text: username) || containsSymbol(text: fullname) {
                        withAnimation(.easeIn) {
                            textFieldContainsSymbol = true
                        }
                    } else {
                        appStateNavigation.push(to: Screen.loading)
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .onChange(of: [fullname, username]) { _ in
            withAnimation(.easeOut) {
                textFieldContainsSymbol = false
            }
        }
    }

    private func inputField(label: String, systemImageName: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.custom("Inter", fixedSize: 14))
                .foregroundColor(.whiteAccent)
                .fontWeight(.medium)
                .padding(.leading, 20)
            ImageTextField(image: Image(systemName: systemImageName), text: text)
        }
    }

    private func containsSymbol(text: String) -> Bool {
        return text.range(of: "[^a-zA-Z0-9]", options: .regularExpression) != nil
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
