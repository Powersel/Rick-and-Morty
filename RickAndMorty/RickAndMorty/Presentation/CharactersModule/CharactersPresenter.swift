import Foundation

protocol CharactersPresenterProtocol {
  func fetchData() async throws
  func getCharacterModels() -> [RMCharacterViewModelProtocol]
}

final class CharactersPresenter {
  
  private enum ActivityState {
    case idle
    case loading
  }
  
  private let networsService: NetworkServiceProtocol
  private let parsingService: ParsingServiceProtocol
  private var rmViewModels: [RMCharacterViewModelProtocol] = []
  
  private var nextPage: String?
  private var activityState: ActivityState = .idle
  
  init(_ networkService: NetworkServiceProtocol = NetworkService(),
       _ parsingService: ParsingServiceProtocol = ParsingService()) {
    self.networsService = networkService
    self.parsingService = parsingService
  }
}

extension CharactersPresenter: CharactersPresenterProtocol {
  func fetchData() async throws {
    if activityState == .loading { return }
    activityState = .loading
    do {
      let urlString = nextPage != nil ? nextPage! : APIEndpoint.characters.path
      let data = try await networsService.fetchData(urlString)
      let dtoModel = try parsingService.parseData(data, RMCharactersData.self)
      nextPage = dtoModel.info.next
      let viewModels = dtoModel.results.map { RMCharacterViewModel($0) }
      rmViewModels.append(contentsOf: viewModels)
      activityState = .idle
    } catch {
      activityState = .idle
      throw RMError.invalidResponse
    }
  }
  
  func getCharacterModels() -> [RMCharacterViewModelProtocol] {
    return rmViewModels
  }
}
