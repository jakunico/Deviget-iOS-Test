//
//  MasterPresenter.swift
//  Deviget-iOS-Test
//
//  Created by Nicolas Jakubowski on 3/20/20.
//  Copyright © 2020 Nicolas Jakubowski. All rights reserved.
//

import Foundation
import UIKit

class MasterPresenter {
    let masterViewController: MasterViewController
    let network: Network
    
    var detailViewController: DetailViewController?
    var nextPage: String?
    var hasMore = true
    var isRequesting = false
    
    init(masterViewController: MasterViewController, network: Network = .shared) {
        self.masterViewController = masterViewController
        self.network = network
        fetchPosts()
    }
    
    private func fetchPosts() {
        guard hasMore else { return }
        guard !isRequesting else { return }
        isRequesting = true
        network.top(request: TopRequest(time: .day, after: nextPage, limit: 10)) { response in
            self.isRequesting = false
            switch response {
            case .error(let error):
                print("MasterPresenter: Failed to fetch posts with error \(error)")
            case .success(let object):
                self.hasMore = object.data.after != nil
                self.nextPage = object.data.after
                let objects = object.data.children.map({ PostViewModel(post: $0) })
                DispatchQueue.main.async { self.masterViewController.addObjects(objects) }
            }
        }
    }
    
    func pullToRefresh() {
        nextPage = nil
        hasMore = true
        masterViewController.actionDismissAll()
        fetchPosts()
    }
    
    // Called when the master displays the last items in the listing.
    func reachedEndOfList() {
        fetchPosts()
    }
    
    // Called when the master receives a segue request.
    func prepare(for segue: UIStoryboardSegue) {
        
        switch segue.identifier {
        case "showDetail":
            
            guard let indexPath = masterViewController.tableView.indexPathForSelectedRow else {
                print("MasterPresenter: Received a 'showDetail' segue but table did not have any selected row")
                return
            }
            
            let viewModel = masterViewController.objects[indexPath.row]
            let viewModelAsRead = viewModel.asRead()
            
            let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            controller.viewModel = viewModelAsRead
            controller.navigationItem.leftBarButtonItem = masterViewController.splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
            detailViewController = controller

            // Mark as read
            masterViewController.replaceObject(viewModel, with: viewModelAsRead)
            
        default:
            print("MasterPresenter: Received unknown segue with identifier: \(String(describing: segue.identifier))")
        }
    }
    
    // Called when the master removes all objects listed.
    func didRemoveAllObjects() {
        detailViewController?.viewModel = nil
    }
    
    // Called when the master removes a specific object listed.
    func didDismissObject(_ object: PostViewModel) {
        if detailViewController?.viewModel?.postIdentifier == object.postIdentifier {
            detailViewController?.viewModel = nil
        }
    }
    
}
