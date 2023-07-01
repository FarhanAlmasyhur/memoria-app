//
//  BottomSheetView.swift
//  Memoria
//
//  Created by Muhammad Farhan Almasyhur on 01/07/23.
//

import SwiftUI

struct BottomSheetView<Content: View>: View {
    @Binding var isPresented: Bool
    let height: CGFloat
    let content: Content
    
    var body: some View {
        ZStack {
            if isPresented {
                Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
                    .onTapGesture { dismiss() }
                
                VStack(spacing: 0) {
                    Spacer()
                    
                    VStack {
                        content
                    }
                    .frame(height: height)
                    .background(Color.white)
                    .cornerRadius(10)
                }
            }
        }

    }
    
    private func dismiss() {
        withAnimation {
            isPresented = false
        }
    }
}

struct BottomSheetModifier<ContentView: View>: ViewModifier {
    @Binding var isPresented: Bool
    let height: CGFloat
    let content: ContentView
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            BottomSheetView(isPresented: $isPresented, height: height, content: self.content)
        }
    }
}
