//
//  AppCoordinator.swift
//  TestAppRickMorty
//
//  Created by NikoS on 02.06.2024.
//

import UIKit
import SwiftUI

protocol Coordinator {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController : UINavigationController { get set }
    
    func start()
}

class AppCoordinator : Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToMain()
    }
    
    let storyboard = UIStoryboard.init(name: "Main", bundle: .main)
    
    func goToMain(){
         let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
         let mainViewModel = MainViewModel.init()
        mainViewModel.coordinator = self
        mainViewController.viewModel = mainViewModel
        navigationController.pushViewController(mainViewController, animated: true)
    }
    
    func goToDetails(character: APICharacterDTO){
        let viewModel = CharacterDetailsViewModel(character: character)
        viewModel.coordinator = self
        let detailsView = CharacterDetailsView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: detailsView)
        hostingController.navigationItem.hidesBackButton = true
        navigationController.pushViewController(hostingController, animated: true)
    }
}
