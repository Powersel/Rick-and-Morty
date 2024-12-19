import Foundation

protocol ParsingServiceProtocol {
  func parseData<T>(_ data: Data, _ model: T.Type) throws -> T where T : Decodable
}

final class ParsingService {
  private let decoder: JSONDecoder
  
  init() {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    self.decoder = decoder
  }
}

extension ParsingService: ParsingServiceProtocol {
  func parseData<T>(_ data: Data, _ model: T.Type) throws -> T where T : Decodable {
    do {
      let model = try decoder.decode(T.self, from: data)
      return model
    } catch {
      throw RMError.parsingFailed
    }
  }
}
