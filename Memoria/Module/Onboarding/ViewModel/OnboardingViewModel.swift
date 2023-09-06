//
//  OnboardingViewModel.swift
//  Memoria
//
//  Created by Muhammad Farhan Almasyhur on 28/08/23.
//

import Foundation
import Combine
import Firebase

class OnboardingViewModel: ObservableObject {
    
    @Published var fullname: String = ""
    @Published var username: String = ""
    @Published var password: String = ""
    
    @Published var userSession: FirebaseAuth.User?
    
    private let authService = AuthService.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscriber()
    }
    
    private func setupSubscriber() {
        authService.$userSession
            .sink { [weak self] userSession in
                self?.userSession = userSession
            }
            .store(in: &cancellables)
    }
    
    func createUser() async throws {
        try await authService.createUser(email: fullname, username: username, password: password)
    }
}
