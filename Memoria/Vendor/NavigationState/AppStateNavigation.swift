//
//  AppStateNavigation.swift
//  Memoria
//
//  Created by Muhammad Farhan Almasyhur on 25/06/23.
//

import Foundation
import NavigationBackport

enum Screen: Hashable {
    case onboarding
    case loading
    case main
    case createParty
}


class AppStateNavigation: ObservableObject {
    
    @Published var path = NBNavigationPath()
    
    @Published var showJoinByQR = false
    @Published var showJoinByCode = false
    
    public static let shared = AppStateNavigation()
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func push<T: Hashable>(to screen: T) {
        path.push(screen)
    }
    
}

