//
//  CircularProgressView.swift
//  Memoria
//
//  Created by Muhammad Farhan Almasyhur on 25/06/23.
//

import SwiftUI

struct CircularProgressView: View {
    let progress: Double
    let mainColor: Color = .purpleButton
    let secondColor: Color = .primaryWhite
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    secondColor.opacity(0.5),
                    lineWidth: 5
                )
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    mainColor,
                    style: StrokeStyle(
                        lineWidth: 5,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                // 1
                .animation(.easeOut, value: progress)

        }
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(progress: 0.5)
    }
}
