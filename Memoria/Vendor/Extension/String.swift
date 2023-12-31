//
//  String.swift
//  Memoria
//
//  Created by Muhammad Farhan Almasyhur on 13/08/23.
//

import Foundation

extension String {
    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss")-> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: self) else { return Date() }
        return date
    }
}
