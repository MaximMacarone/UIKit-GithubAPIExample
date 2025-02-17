//
//  FollowerListViewController.swift
//  UIKitExperiments
//
//  Created by Maxim Makarenkov on 08.02.2025.
//

import UIKit
import Combine

class FollowerListViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    // MARK: - properties
    
    let viewModel: FollowerListViewModel
    var subscriptions = Set<AnyCancellable>()

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    // MARK: - init
    
    init(viewModel: FollowerListViewModel) {
        
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureCollectionView()
        configureSearchController()
        configureDataSource()
        сonfigureSubscriptions()
        
        viewModel.statePublisher.send(.viewDidLoad)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    // MARK: - UI configuration
    
    private func configureNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createCollectionViewFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        
        collectionView.delegate = self
    }
    
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a user"
        searchController.searchBar.searchTextField.defaultTextAttributes = [.font: UIFont.systemFont(ofSize: 16, weight: .regular, width: .expanded)]
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.autocorrectionType = .no
        
        navigationItem.searchController = searchController
        
    }
    
    // MARK: - subscriptions
    
    private func сonfigureSubscriptions() {
        configureFollowersSubscription()
        configureIsLoadingSubscription()
    }
    
    private func configureFollowersSubscription() {
        viewModel.followersPublisher
            .sink { [unowned self] completion in
                switch completion {
                case .failure(let error):
                    self.presentGFAlertOnMainThread(title: "There was an error", message: error.rawValue, buttonTitle: "Close") {
                        DispatchQueue.main.async {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                case .finished:
                    print("viewModel.followers finished")
                }
            } receiveValue: { [unowned self] followers in
                self.updateData(with: followers)
            }
            .store(in: &subscriptions)
    }
    
    private func configureIsLoadingSubscription() {
        viewModel.isLoadingPublisher
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] isLoading in
                if isLoading {
                    showNavBarLoadingIndicator(animated: true)
                } else {
                    dismissNavBarLoadingIndicator(animated: true)
                }
            }
            .store(in: &subscriptions)
    }
    
    // MARK: - methods
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: {
            (collectionView, IndexPath, follower) -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: IndexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    private func updateData(with followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

// MARK: - extensions

extension FollowerListViewController: UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.height
        
        if offsetY + frameHeight >= contentHeight {
            if viewModel.hasMoreFollowers {
                viewModel.statePublisher.send(.scrollViewDidEndDecelerating)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let follower = viewModel.followersPublisher.value[indexPath.item]
        print("did select \(follower.login)")
        
        let userInfoVC = UserInfoViewController()
        let navController = UINavigationController(rootViewController: userInfoVC)
        
        present(navController, animated: true)
    }

}

extension FollowerListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
//        updateData(with: filteredFollowers)
    }
}

extension FollowerListViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.statePublisher.send(.searchDidEnd)
//        updateData(with: followers)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewModel.statePublisher.send(.searchWillStart)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchFilter.send(searchText)
    }
}
