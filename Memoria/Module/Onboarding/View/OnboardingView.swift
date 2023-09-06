//
//  OnboardingView.swift
//  Memoria
//
//  Created by Muhammad Farhan Almasyhur on 25/06/23.
//

import SwiftUI
import MemojiKit

struct OnboardingView: View {
    
    @StateObject private var viewModel = OnboardingViewModel()
    
    @State private var textFieldContainsSymbol: Bool = false
    @State private var securePassword: Bool = true
    
    @StateObject private var appStateNavigation = AppStateNavigation.shared

    var body: some View {
        ZStack {
            Color.blackAccent
                .edgesIgnoringSafeArea(.all)
            VStack {
                
                inputField(label: "Full Name", systemImageName: "person", text: $viewModel.fullname)
                
                inputField(label: "Username", systemImageName: "at", text: $viewModel.username)
                
                secureField()
                
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
                    if containsSymbol(text: viewModel.username) || containsSymbol(text: viewModel.fullname) {
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
        .onChange(of: [viewModel.fullname, viewModel.username]) { _ in
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
    
    private func secureField() -> some View {
        VStack(alignment: .leading) {
            Text("Password")
                .font(.custom("Inter", fixedSize: 14))
                .foregroundColor(.whiteAccent)
                .fontWeight(.medium)
                .padding(.leading, 20)
            HStack {
                if securePassword {
                    SecureField("", text: $viewModel.password)
                        .font(.custom("Inter", fixedSize: 15))
                        .foregroundColor(.blackAccent)
                } else {
                    TextField("", text: $viewModel.password)
                        .font(.custom("Inter", fixedSize: 15))
                        .foregroundColor(.blackAccent)
                }
                let imageName = securePassword ? "eye.fill" : "eye.slash.fill"
                Image(systemName: imageName)
                    .font(.system(size: 15))
                    .onTapGesture {
                        withAnimation {
                            securePassword.toggle()
                        }
                    }
            }.padding(.vertical, 10)
                .background(Color.white, alignment: .center)
                .cornerRadius(5)
            .padding(.horizontal, 20)
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
