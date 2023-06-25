//
//  OnboardingView.swift
//  Memoria
//
//  Created by Muhammad Farhan Almasyhur on 25/06/23.
//

import SwiftUI

struct OnboardingView: View {
    
    @State var fullname: String = ""
    @State var username: String = ""
    @State var textFieldContainsSymbol: Bool = false
    
    @StateObject var appStateNavigation = AppStateNavigation.shared
    
    var body: some View {
        ZStack {
            Color.blackAccent
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack(alignment: .leading) {
                    Text("Full Name")
                        .font(.custom("Inter", fixedSize: 14))
                        .foregroundColor(.whiteAccent)
                        .fontWeight(.medium)
                        .padding(.leading, 20)
                    ImageTextField(image: Image(systemName: "person"), text: $fullname)
                    
                }
                VStack(alignment: .leading) {
                    Text("Username")
                        .font(.custom("Inter", fixedSize: 14))
                        .foregroundColor(.whiteAccent)
                        .fontWeight(.medium)
                        .padding(.leading, 20)
                    ImageTextField(image: Image(systemName: "at"), text: $username)
                    if textFieldContainsSymbol == true {
                        Text("Only alphabets and numerals are allowed")
                            .font(.custom("Inter", fixedSize: 12))
                            .foregroundColor(.red)
                            .fontWeight(.medium)
                            .padding(.leading, 20)
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
                    if checkTextField(text: username) == true || checkTextField(text: fullname) == true {
                        withAnimation(.easeIn) {
                            textFieldContainsSymbol = true
                        }
                    } else {
                        appStateNavigation.push(to: Screen.loading)
                    }
                }
            }
        }.navigationBarHidden(true)
            .onChange(of: fullname) { _ in
                withAnimation(.easeOut) {
                    textFieldContainsSymbol = false
                }
            }
            .onChange(of: username) { _ in
                withAnimation(.easeOut) {
                    textFieldContainsSymbol = false
                }
            }
    }
    
    private func checkTextField(text: String) -> Bool {
        return text.range(of: "[ !\"#$%&'()*+,-./:;<=>?@\\[\\\\\\]^_`{|}~]+", options: .regularExpression) != nil
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
