//
//  FollowerListViewModel.swift
//  UIKitExperiments
//
//  Created by Maxim Makarenkov on 11.02.2025.
//
import Foundation
import Combine

class FollowerListViewModel: ObservableObject {
    
    enum ViewControllerStates {
        case viewDidLoad
        case scrollViewDidEndDecelerating
        case searchWillStart
        case searchDidEnd
    }
    
    // MARK: - dependencies
    
    private let networkService: UserAPIService
    
    // MARK: - properties
    
    private let username: String
    private var page = 1
    var hasMoreFollowers = true
    
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - publishers
    
    let searchFilter = CurrentValueSubject<String, Never>("")
    let followersPublisher = CurrentValueSubject<[Follower], GFError>([])
    let allFollowersPublisher = CurrentValueSubject<[Follower], Never>([])
    let statePublisher = PassthroughSubject<FollowerListViewModel.ViewControllerStates, Never>()
    let isLoadingPublisher = CurrentValueSubject<Bool, Never>(false)
    
    // MARK: - init
    
    init(
        networkService: UserAPIService,
        username: String
    ) {
        print("viewModel init")
        self.username = username
        self.networkService = networkService
        configureSubscriptions()
    }
    
    // MARK: - subscriptions
    
    private func configureSubscriptions() {
        configureStatePublisher()
        configureSearchFilter()
    }
    
    private func configureStatePublisher() {
        statePublisher
            .sink { [unowned self] state in
                switch state {
                case .viewDidLoad, .scrollViewDidEndDecelerating:
                    self.getFollowers(of: username, page: page)
                    self.page += 1
                case .searchWillStart:
                    print("searchWillStart")

                case .searchDidEnd:
                    print("searchDidEnd")
                    self.followersPublisher.send(self.allFollowersPublisher.value)
                }
            }
            .store(in: &subscriptions)
    }
    
    private func configureSearchFilter() {
        searchFilter
            .combineLatest(allFollowersPublisher)
            .map { searchFilter, followers in
                searchFilter.isEmpty
                ? followers
                : followers.filter { $0.login.lowercased().contains(searchFilter.lowercased()) }
            }
            .sink { [unowned self] filteredFollowers in
                self.followersPublisher.send(filteredFollowers)
            }
            .store(in: &subscriptions)
    }
    
    // MARK: - methods
    
    private func getFollowers(of username: String, page: Int) {
        isLoadingPublisher.send(true)
        networkService.getFollowers(for: username, page: page)
            .sink { [unowned self] completion in
                switch completion {
                case .finished:
                    self.isLoadingPublisher.send(false)
                case .failure(let error):
                    self.isLoadingPublisher.send(false)
                    self.followersPublisher.send(completion: .failure(error))
                }
            } receiveValue: { [unowned self] followers in
                if followers.count < 100 {
                    self.hasMoreFollowers = false
                }
                self.allFollowersPublisher.send(self.allFollowersPublisher.value + followers)
            }
            .store(in: &subscriptions)
    }
}
