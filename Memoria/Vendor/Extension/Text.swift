//
//  Font.swift
//  Memoria
//
//  Created by Muhammad Farhan Almasyhur on 13/08/23.
//

import SwiftUI

extension Text {
    func interFont(size: CGFloat) -> Text {
        self.font(.custom("Inter", fixedSize: size))
    }
}
