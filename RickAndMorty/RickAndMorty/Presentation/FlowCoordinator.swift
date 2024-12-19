import UIKit

struct FlowCoordinator {
  
  private weak var naviController: UINavigationController?
  
  init(_ navigationConrtoller: UINavigationController) {
    self.naviController = navigationConrtoller
  }
  
  func presentHomeScreen() {
    let presenter = CharactersPresenter()
    let charactersController = CharactersViewController(presenter: presenter)
    naviController?.pushViewController(charactersController, animated: true)
  }
}
