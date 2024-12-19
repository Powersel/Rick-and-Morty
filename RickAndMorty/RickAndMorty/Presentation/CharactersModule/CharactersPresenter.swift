import Foundation

protocol CharactersPresenterProtocol {
  func fetchData() async throws
  func getCharacterModels() -> [RMCharacterViewModelProtocol]
}

final class CharactersPresenter {
  
  private let networsService: NetworkServiceProtocol
  private let parsingService: ParsingServiceProtocol
  private var rmViewModels: [RMCharacterViewModelProtocol] = []
  
  init(_ networkService: NetworkServiceProtocol = NetworkService(),
       _ parsingService: ParsingServiceProtocol = ParsingService()) {
    self.networsService = networkService
    self.parsingService = parsingService
  }
}

extension CharactersPresenter: CharactersPresenterProtocol {
  func fetchData() async throws {
    do {
      let urlString = APIEndpoint.characters.path
      let data = try await networsService.fetchData(urlString)
      let dtoModel = try parsingService.parseData(data, RMCharactersData.self)
      rmViewModels = dtoModel.results.map { RMCharacterViewModel($0, networsService) }
    } catch {
      throw RMError.invalidResponse
    }
  }
  
  func getCharacterModels() -> [RMCharacterViewModelProtocol] {
    return rmViewModels
  }
}
