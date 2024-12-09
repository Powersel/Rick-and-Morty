import Foundation

protocol NetworkServiceProtocol {
  func fetchCharacters(_ urlString: String) async throws -> RMCharactersData
  //    func getCharacterDetails(id: Int) async throws -> Character
  //    func getImageData(url: URL) async throws -> Data
}

final class NetworkService {
  var session = URLSession.shared
  let decoder = JSONDecoder()
}

extension NetworkService: NetworkServiceProtocol {
  func fetchCharacters(_ urlString: String) async throws -> RMCharactersData {
    let url = URL(string: urlString)!
    let (data, responce) = try await session.data(from: url)
    
    guard let httpResponce = responce as? HTTPURLResponse,
          httpResponce.statusCode == 200 else {
      throw RMError.invalidResponse
    }
//    decoder.keyDecodingStrategy = .convertFromSnakeCase
    
    return try decoder.decode(RMCharactersData.self, from: data)
  }
}
