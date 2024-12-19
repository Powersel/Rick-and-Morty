import UIKit

protocol RMCharactersModelProtocol {
  var charactersList: [RMCharacterViewModelProtocol] { get }
  func fetchData() async throws
}

protocol RMCharacterViewModelProtocol {
  var name: String { get }
  func loadImage() async throws -> UIImage?
}

final class RMCharacterViewModel: RMCharacterViewModelProtocol {
  
  var name: String { dtoModel.name }
  
  private let dtoModel: RMCharacter
  private let networkService: NetworkServiceProtocol
  
  init(_ dtoModel: RMCharacter, _ networkService: NetworkServiceProtocol) {
    self.dtoModel = dtoModel
    self.networkService = networkService
  }
  
  func loadImage() async throws -> UIImage? {
    do {
      let imageData = try await networkService.fetchData(dtoModel.image)
      return UIImage(data: imageData)
    } catch {
      throw RMError.invalidResponse
    }
  }
}
