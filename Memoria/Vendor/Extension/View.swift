//
//  View.swift
//  Memoria
//
//  Created by Muhammad Farhan Almasyhur on 01/07/23.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func bottomSheet<Content: View>(isPresented: Binding<Bool>, height: CGFloat, @ViewBuilder content: () -> Content) -> some View {
        self.modifier(BottomSheetModifier(isPresented: isPresented, height: height, content: content()))
    }
}
