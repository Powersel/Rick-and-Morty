import UIKit

protocol AppCoordinator {
  func presentHomeScreen()
  func presentCharacterScreen(_ viewModel: RMCharacterViewModelProtocol)
  
  func navigationBack()
}

struct FlowCoordinator {
  
  private weak var naviController: UINavigationController?
  
  init(_ navigationConrtoller: UINavigationController) {
    self.naviController = navigationConrtoller
  }
}

extension FlowCoordinator: AppCoordinator {
  func presentHomeScreen() {
    let presenter = CharactersPresenter(coordinator: self)
    let charactersController = CharactersViewController(presenter: presenter)
    naviController?.pushViewController(charactersController, animated: true)
  }
  
  func presentCharacterScreen(_ viewModel: RMCharacterViewModelProtocol) {
    let controller = CharacterDetailsScreen(viewModel: viewModel)
    naviController?.pushViewController(controller, animated: true)
  }
  
  func navigationBack() {
    naviController?.popViewController(animated: true)
  }
}
