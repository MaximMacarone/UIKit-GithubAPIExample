//
//  FollowerListViewController.swift
//  UIKitExperiments
//
//  Created by Maxim Makarenkov on 08.02.2025.
//

import UIKit

class FollowerListViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    var username: String!
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!

    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var followersCount: Int!
    var page = 1
    var hasMoreFollowers = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureCollectionView()
        configureSearchController()
        getFollowers(username: username, page: page)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
    
    private func getFollowers(username: String, page: Int) {
        showNavBarLoadingIndicator(animated: true)
        NetworkManager.shared.getFollowers(for: username, page: page, completion: {[weak self] result in
            guard let self = self else { return }
            self.hideNavBarLoadingIndicator(animated: true)
            switch result {
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "There was an error", message: error.rawValue, buttonTitle: "Close")
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            case .success(let followers):
                self.followers.append(contentsOf: followers)
                if followers.count < 100 { self.hasMoreFollowers = false }
                
                if self.followers.isEmpty {
                    let message = "\(username) doesn't have any followers yet. Go follow them!"
                    DispatchQueue.main.async {
                        self.showEmptyStateView(in: self.view, message: message)
                    }
                    return
                }
                
                self.updateData(with: self.followers)
            }
        })
    }
    
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

extension FollowerListViewController: UICollectionViewDelegate {
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        let offsetY = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height
//        let frameHeight = scrollView.frame.height
//        
//        if offsetY + frameHeight == contentHeight {
//            guard hasMoreFollowers else { return }
//            page += 1
//            getFollowers(username: username, page: page)
//        }
//    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.height
        
        print(offsetY)
        print(contentHeight)
        print(frameHeight)
        
        if offsetY + frameHeight >= contentHeight {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }

}

extension FollowerListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            return
        }
        
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(with: filteredFollowers)
    }
}

extension FollowerListViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(with: followers)
    }
}
