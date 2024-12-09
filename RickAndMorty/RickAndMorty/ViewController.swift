import UIKit

class ViewController: UIViewController {

  let networkService = NetworkService()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchChars()
  }
  
  func fetchChars() {
    Task { [weak self] in
      do {
        let models = try await self?.networkService.fetchCharacters(APIEndpoint.episodes.path)
        print(models)
      } catch let error {
        print(error)
      }
    }
  }
}
