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
}


class AppStateNavigation: ObservableObject {
    
    @Published var path = NBNavigationPath()
    
    public static let shared = AppStateNavigation()
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func push<T: Hashable>(to screen: T) {
        path.push(screen)
    }
    
}

