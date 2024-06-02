//
//  ViewController.swift
//  TestAppRickMorty
//
//  Created by NikoS on 27.05.2024.
//

import UIKit
import SwiftUI

protocol MainViewControllerDelegate: AnyObject {
    func characterListView(
        _ mainViewController: MainViewController,
        didSelectCharacter character: APICharacterDTO
    )
}

class MainViewController: UIViewController {
    
    public weak var delegate: MainViewControllerDelegate?
    
    var viewModel = MainViewModel()
    let titleLabel = UILabel()
    var buttonView: SortButtonsView? = nil
    let tableView = UITableView()
    let spinner = UIActivityIndicatorView()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonView = SortButtonsView(action: { [weak self] selectedTitle in
            self?.didSortCharacters(selectedStatus: selectedTitle)
        })
        setupTableView()
        setupUI()
        self.tableView.isHidden = true
        spinner.startAnimating()
        viewModel.delegate = self
        self.delegate = self
        viewModel.fetchCharacters()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            CharacterTableViewCell.self,
            forCellReuseIdentifier: CharacterTableViewCell.cellIdentifier)
        tableView.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.cellIdentifier, for: indexPath) as! CharacterTableViewCell
        cell.configure(with: viewModel.sortedData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sortedData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let character = viewModel.findSelectedCharacter(index: indexPath.row) else { return }
        viewModel.delegate?.didSelectCharacter(character)
    }
    
}

extension MainViewController {
    private func setupUI() {
        spinner.style = .large
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner)
        
        titleLabel.text = AppConstants.mainScreenTitle
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.systemFont(ofSize: Style().titleFont, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        let hostingController = UIHostingController(rootView: buttonView)
        addChild(hostingController)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hostingController.view)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: Style().spinnerSize),
            spinner.heightAnchor.constraint(equalToConstant: Style().spinnerSize),
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Style().baseConstraint),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Style().baseConstraint),
            
            hostingController.view.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Style().baseConstraint),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Style().baseConstraint),
            
            tableView.topAnchor.constraint(equalTo: hostingController.view.bottomAnchor, constant: Style().baseConstraint),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Style().zeroConstraint),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Style().zeroConstraint),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Style().zeroConstraint)
        ])
        hostingController.didMove(toParent: self)
    }
}

extension MainViewController: MainViewModelDelegate {
    func didSortCharacters(selectedStatus: CharacterStatus) {
        viewModel.sortTable(status: selectedStatus)
    }
    
    func didLoadInitialCharacters() {
        spinner.stopAnimating()
        tableView.isHidden = false
        tableView.reloadData()
        UIView.animate(withDuration: 0.4) {
            self.tableView.alpha = 1
        }
    }
    
    func didSelectCharacter(_ character: APICharacterDTO) {
        delegate?.characterListView(self, didSelectCharacter: character)
    }
    
    func didLoadMoreCharacters() {
        tableView.reloadData()
    }
}

extension MainViewController: MainViewControllerDelegate {
    func characterListView(_ mainViewController: MainViewController, didSelectCharacter character: APICharacterDTO) {
        viewModel.goToDetails(character: character)
    }
}

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard viewModel.shouldLoadMoreIndicator,
            !viewModel.isLoadingMoreCharacters,
            !viewModel.sortedData.isEmpty,
            let nextURLString = viewModel.apiInfo?.next,
            let url = URL(string: nextURLString) else {
            return
        }
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        if offsetY > (contentHeight - height - 100) {
            viewModel.fetchAdditionalCharacters(url: url)
        }
    }
}
