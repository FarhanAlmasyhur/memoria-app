//
//  AuthService.swift
//  Memoria
//
//  Created by Muhammad Farhan Almasyhur on 28/08/23.
//

import Foundation
import FirebaseAuth

class AuthService: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService()
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    func login(withEmail email: String, password: String) async throws {
        
    }
    
    func createUser(email: String, username: String, password: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
        } catch {
            print("DEBUG: Error \(error.localizedDescription)")
        }
        
    }
    
    
}
