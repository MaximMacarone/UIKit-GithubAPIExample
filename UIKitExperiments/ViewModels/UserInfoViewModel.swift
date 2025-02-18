//
//  UserInfoViewModel.swift
//  UIKitExperiments
//
//  Created by Maxim Makarenkov on 18.02.2025.
//

import Foundation
import Combine

final class UserInfoViewModel: ObservableObject {
    
    enum VCState {
        case viewDidLoad
    }
    
    // MARK: - dependencies
    
    let networkService: UserAPIService
    
    // MARK: - properties
    
    let username: String
    
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - publishers
    
    let userInfoPublisher = PassthroughSubject<User, GFError>()
    let vcStatePublisher = PassthroughSubject<VCState, Never>()
    
    // MARK: - init
    
    init(username: String, networkService: UserAPIService) {
        self.networkService = networkService
        self.username = username
        configureSubscriptions()
    }
    
    // MARK: - subscriptions
    
    private func configureSubscriptions() {
        configureVCStateSubscription()
    }
    
    private func configureVCStateSubscription() {
        vcStatePublisher
            .sink { [unowned self] state in
                switch state {
                case .viewDidLoad:
                    self.getUserInfo()
                }
            }
            .store(in: &subscriptions)

    }
    
    // MARK: - methods
    
    
    func getUserInfo() {
        networkService.getUserInfo(for: username)
            .sink { [unowned self] completion in
                switch completion {
                case .finished:
                    print("getUserInfo finished")
                case .failure(let error):
                    print("getUserInfo failed: \(error)")
                    self.userInfoPublisher.send(completion: .failure(error))
                }
            } receiveValue: { [unowned self] user in
                self.userInfoPublisher.send(user)
            }
            .store(in: &subscriptions)

    }
    
}
