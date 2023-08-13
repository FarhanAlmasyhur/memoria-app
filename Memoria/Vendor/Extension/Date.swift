//
//  Date.swift
//  Memoria
//
//  Created by Muhammad Farhan Almasyhur on 13/08/23.
//

import Foundation

extension Date {
    func toString(withFormat format: String = "dd MMMM yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)
        return str
    }
}
