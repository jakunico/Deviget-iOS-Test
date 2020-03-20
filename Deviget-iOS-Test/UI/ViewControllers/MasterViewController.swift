//
//  MasterViewController.swift
//  Deviget-iOS-Test
//
//  Created by Nicolas Jakubowski on 3/19/20.
//  Copyright © 2020 Nicolas Jakubowski. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
    // MARK: - Internal
    private(set) var objects = [PostViewModel]() {
        didSet {
            if objects.count > 0 {
                addTrashButton()
            } else {
                presenter.didRemoveAllObjects()
                removeTrashButton()
            }
        }
    }
    
    /// Adds the given objects to the listing
    func addObjects(_ objectsToAdd: [PostViewModel]) {
        tableView.beginUpdates()
        objectsToAdd.forEach {
            objects.append($0)
            tableView.insertRows(at: [IndexPath(row: objects.count - 1, section: 0)], with: .automatic)
        }
        tableView.endUpdates()
        tableView.refreshControl?.endRefreshing()
    }
    
    /// Replaces the given object on the list with the new one.
    /// Animates content update on the cell.
    func replaceObject(_ object: PostViewModel, with newObject: PostViewModel) {
        if let index = objects.firstIndex(where: { $0.postIdentifier == object.postIdentifier }) {
            objects[index] = newObject
            // Animation adds a little "slide" effect to the read > unread transition
            UIView.animate(withDuration: 0.3) {
                (self.tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? PostTableCell)?.viewModel = newObject
            }
        }
    }
    
    // MARK: - Private

    private var presenter: MasterPresenter!

    // MARK: - Initialization
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        fatalError("MasterViewController.init(style:) is not implemented")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        presenter = MasterPresenter(masterViewController: self)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("MasterViewController.init(nibName:bundle:) is not implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        func removeSeparatorLines() {
            tableView.tableFooterView = UIView() // Removes separator lines in unused cells
        }
        
        func addRefreshControl() {
            tableView.refreshControl = UIRefreshControl() .. {
                $0.addTarget(self, action: #selector(actionPullToRefresh), for: .valueChanged)
            }
        }
        
        removeSeparatorLines()
        addRefreshControl()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    // MARK: - UI utility
    
    func addTrashButton() {
        let trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(actionDismissAll))
        navigationItem.rightBarButtonItem = trashButton
    }
    
    func removeTrashButton() {
        navigationItem.rightBarButtonItem = nil
    }
    
    // MARK: - Actions

    @objc func actionPullToRefresh() {
        presenter.pullToRefresh()
    }
    
    @objc func actionDismissAll() {
        guard objects.count > 0 else { return } // Nothing to dismiss
        
        tableView.beginUpdates()
        let indexPaths = objects.enumerated().map({ IndexPath(row: $0.offset, section: 0) })
        tableView.deleteRows(at: indexPaths, with: .left)
        objects.removeAll()
        tableView.endUpdates()
        
    }
    
    func actionDismiss(cell: PostTableCell) {
        guard let viewModel = cell.viewModel else { return }
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        tableView.beginUpdates()
        objects.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        tableView.endUpdates()
        
        presenter.didDismissObject(viewModel)
    }
    
    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.prepare(for: segue)
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? PostTableCell else {
            fatalError("Unable to dequeue PostTableCell, Storyboard containing MasterViewController probably got corrupted.")
        }
        
        cell.delegate = self
        cell.viewModel = objects[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == objects.count - 1 {
            presenter.reachedEndOfList()
        }
    }

}

extension MasterViewController: PostTableCellDelegate {
    func postTableCellDidTapDismiss(cell: PostTableCell) {
        actionDismiss(cell: cell)
    }
}
