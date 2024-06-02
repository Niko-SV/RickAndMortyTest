//
//  MainViewModel.swift
//  TestAppRickMorty
//
//  Created by NikoS on 29.05.2024.
//

import Foundation

protocol MainViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
    func didLoadMoreCharacters()
    func didSelectCharacter(_ character: APICharacterDTO)
    func didSortCharacters(selectedStatus: CharacterStatus)
}

final class MainViewModel {
    
    public weak var delegate: MainViewModelDelegate?
    weak var coordinator: AppCoordinator?
    
    public var isLoadingMoreCharacters = false
    private var selectedCharacterStatus: CharacterStatus? = nil
    
    var cellViewModels: [CharacterTableViewCellViewModel] = []
    var sortedData: [CharacterTableViewCellViewModel] = []
    
    private var characters: [APICharacterDTO] = [] {
        didSet {
            for character in characters{
                let viewModel = CharacterTableViewCellViewModel(
                    id: character.id,
                    characterName: character.name,
                    characterSpecies: character.species.capitalized,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image)
                )
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                    appendSortedDataIfNeeded(viewModel: viewModel)
                }
            }
        }
    }
    
    func goToDetails(character: APICharacterDTO){
        coordinator?.goToDetails(character: character)
    }
    
    func findSelectedCharacter(index: Int) -> APICharacterDTO? {
        let model = sortedData[index]
        return characters.first { $0.id == model.id}
    }
    
    private func appendSortedDataIfNeeded(viewModel: CharacterTableViewCellViewModel) {
        guard selectedCharacterStatus == nil
                || viewModel.characterStatus == selectedCharacterStatus else {
            return
        }
        sortedData.append(viewModel)
    }
    
    func sortTable(status: CharacterStatus) {
        if(selectedCharacterStatus == status) {
            selectedCharacterStatus = nil
            sortedData = cellViewModels
        } else {
            selectedCharacterStatus = status
            sortedData = cellViewModels.filter { $0.characterStatus == status }
        }
        
        DispatchQueue.main.async {
            self.delegate?.didLoadInitialCharacters()
        }
    }
    
    var apiInfo: APICharacterInfoListDTO.Info? = nil
    
    public func fetchCharacters() {
        NetworkService.shared.fetch(
            .init(endpoint: .character),
            model: APICharacterInfoListDTO.self
        ) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                let info = responseModel.info
                self?.characters = results
                self?.apiInfo = info
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    public func fetchAdditionalCharacters(url: URL) {
        guard !isLoadingMoreCharacters else { return }
        
        isLoadingMoreCharacters = true
        guard let request = NetworkRequest(url: url) else {
            isLoadingMoreCharacters = false
            return
        }
        NetworkService.shared.fetch(request, model: APICharacterInfoListDTO.self) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let responseModel):
                let moreResults = responseModel.results
                let info = responseModel.info
                strongSelf.apiInfo = info
                strongSelf.characters.append(contentsOf: moreResults)
                DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadMoreCharacters()
                    strongSelf.isLoadingMoreCharacters = false
                }
            case .failure(_):
                strongSelf.isLoadingMoreCharacters = false
            }
        }
    }
    
    public var shouldLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
    
}
