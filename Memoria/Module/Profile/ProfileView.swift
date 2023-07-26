//
//  ProfileView.swift
//  Memoria
//
//  Created by Muhammad Farhan Almasyhur on 26/07/23.
//

import SwiftUI
struct ProfileView: View {
    
    @State var openLink: Bool = false
    
    private let headerTextColor = Color(hex: "737373")
    private let primaryTextColor = Color.white
    private let secondaryTextColor = Color(hex: "#737373")
    private let backgroundColor = Color.blackBg

    init() {
        UITableView.appearance().backgroundColor = UIColor(Color.blackBg)
        UITableView.appearance().isScrollEnabled = false
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                profileHeader()
                    .padding(.vertical, 35)
                    .frame(width: geometry.size.width)
                    .background(backgroundColor)

                if #available(iOS 16, *) {
                    profileList()
                        .listStyle(.grouped)
                        .scrollContentBackground(.hidden)
                        .scrollDisabled(true)
                        .environment(\.defaultMinListRowHeight, 20)
                        .environment(\.defaultMinListHeaderHeight, 10)
                } else {
                    profileList()
                        .listStyle(.grouped)
                        .environment(\.defaultMinListRowHeight, 20)
                        .environment(\.defaultMinListHeaderHeight, 10)
                }
            }
        }
        .background(Color.blackAccent)
    }
}

// Helper functions for ProfileView components
extension ProfileView {
    func profileHeader() -> some View {
        VStack(spacing: 10) {
            Image("ic_profile")
                .resizable()
                .scaledToFit()
                .frame(height: 100)
            Text("Saffan")
                .font(.custom("Inter", fixedSize: 20))
                .fontWeight(.bold)
                .foregroundColor(.softWhite)
            Text("@saffanf")
                .font(.custom("Inter", fixedSize: 14))
                .fontWeight(.medium)
                .foregroundColor(Color(hex: "#737373"))
        }
    }

    func profileListItem(systemName: String, title: String, textColor: Color, url: String) -> some View {
        HStack {
            Image(systemName: systemName)
                .foregroundColor(textColor)
            Text(title)
                .font(.custom("Inter", fixedSize: 14))
                .fontWeight(.medium)
                .foregroundColor(primaryTextColor)
        }
        .listRowBackground(backgroundColor)
        .onTapGesture {
            self.openLink(url: url)
        }
    }

    func profileList() -> some View {
        List {
            Section(header: Text("Help")
                        .font(.custom("Inter", fixedSize: 13))
                        .fontWeight(.bold)
                        .foregroundColor(headerTextColor)) {
                profileListItem(systemName: "envelope", title: "Email Support", textColor: secondaryTextColor, url: "mailto:contact.memoria.id@gmail.com")
                profileListItem(systemName: "bubble.left.and.bubble.right", title: "WhatsApp Support", textColor: secondaryTextColor, url: "https://wa.me/6281395098451")
            }

            Section(header: Text("Company")
                        .font(.custom("Inter", fixedSize: 13))
                        .fontWeight(.bold)
                        .foregroundColor(headerTextColor)) {
                profileListItem(systemName: "building", title: "About Us", textColor: secondaryTextColor, url: "https://www.memoria.id/about")
                profileListItem(systemName: "star", title: "Rate Us on App Store", textColor: secondaryTextColor, url: "appstore.com")
            }

            Section(header: Text("Account")
                        .font(.custom("Inter", fixedSize: 13))
                        .fontWeight(.bold)
                        .foregroundColor(headerTextColor)) {
                profileListItem(systemName: "rectangle.portrait.and.arrow.forward", title: "Logout", textColor: secondaryTextColor, url: "www.google.com")
            }
        }
    }
    
    private func openLink(url: String) {
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
