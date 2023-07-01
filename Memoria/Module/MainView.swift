//
//  MainView.swift
//  Memoria
//
//  Created by Muhammad Farhan Almasyhur on 26/06/23.
//

import SwiftUI
import CodeScanner

enum TabType {
    case home, party, profile
}

struct MainView: View {
    
    @StateObject var appStateNavigation = AppStateNavigation.shared
    @State private var selectedTab: TabType = .home
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if selectedTab == .home {
                    HomeView()
                        .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
                } else if selectedTab == .party {
                    EmptyView()
                } else if selectedTab == .profile {
                    EmptyView()
                }
                
                Spacer()
                
                CustomTabView(selectedTab: $selectedTab)
            }.edgesIgnoringSafeArea(.bottom)
             .background(Color.blackBg)
             .navigationBarHidden(true)
             .bottomSheet(isPresented: $appStateNavigation.showJoinByQR, height: geometry.size.height * 0.6, content: {
                 ScanQRView()
             })
             .bottomSheet(isPresented: $appStateNavigation.showJoinByCode, height: geometry.size.height * 0.2, content: {
                 JoinByCodeView(height: geometry.size.height * 0.2)
             })
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

struct CustomTabView: View {
    @Binding var selectedTab: TabType
        
        var body: some View {
            HStack(spacing: 30) {
                Spacer()
                TabButton(type: .home, imageName: "house", title: "Home", selectedTab: $selectedTab)
                TabButton(type: .party, imageName: "plus.circle", title: "Create Party", selectedTab: $selectedTab)
                TabButton(type: .profile, imageName: "person", title: "Profile", selectedTab: $selectedTab)
                Spacer()
            }
            .ignoresSafeArea()
            .frame(height: UIScreen.main.bounds.height * 0.1)
            .padding(.bottom, 30)
            .background(Color.blackBg)
        }
}

struct TabButton: View {
    let type: TabType
    let imageName: String
    let title: String
    @Binding var selectedTab: TabType
    
    var body: some View {
        Button(action: {
            selectedTab = type
        }) {
            Image(systemName: imageName)
                .font(.system(size: 20))
                .foregroundColor(selectedTab == type ? .white : .gray)
                .padding(.horizontal, 32)
                .padding(.vertical, 15)
                .background(selectedTab == type ? Color(hex: "#6366F1").opacity(0.4) : Color.clear)
                .border(selectedTab == type ? Color(hex: "#6366F1").opacity(0.5) : Color.clear)
                .cornerRadius(6)
        }
    }
}
