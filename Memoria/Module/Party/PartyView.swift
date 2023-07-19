//
//  PartyView.swift
//  Memoria
//
//  Created by Muhammad Farhan Almasyhur on 05/07/23.
//

import SwiftUI

struct PartyView: View {
    
    @StateObject var appStateNavigation = AppStateNavigation.shared
    @State var preselectedIndex: Int = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                CustomSegmentedControl(preselectedIndex: $preselectedIndex, options: ["Your Party", "As Participant"])
                    .padding(.top, 50)
                    .padding(.horizontal, 24)
                Spacer()
                VStack {
                    Text("You don't have an active party")
                        .font(.custom("Inter", fixedSize: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(.whiteAccent)
                    LargeButton(title: "+ Create Party", backgroundColor: .purpleButton, foregroundColor: .white) {
                        appStateNavigation.push(to: Screen.createParty)
                    }.frame(width: 250)
                }
                Spacer()
                
            }
        }   .background(Color.blackAccent)
    }
}

struct PartyView_Previews: PreviewProvider {
    static var previews: some View {
        PartyView()
    }
}
