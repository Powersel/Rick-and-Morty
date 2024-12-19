import Foundation

protocol NetworkServiceProtocol {
  func fetchData(_ urlString: String) async throws -> Data
}

final class NetworkService {
  private let session: URLSession
  
  init() {
    let configuration = URLSessionConfiguration.default
    configuration.waitsForConnectivity = true
    configuration.timeoutIntervalForRequest = 30
    
    let urlSession = URLSession(configuration: configuration)
    
    self.session = urlSession
  }
}

extension NetworkService: NetworkServiceProtocol {
  func fetchData(_ urlString: String) async throws -> Data {
    let url = URL(string: urlString)!
    let (data, responce) = try await session.data(from: url)
    
    guard let httpResponce = responce as? HTTPURLResponse,
          httpResponce.statusCode == 200 else {
      throw RMError.invalidResponse
    }
    
    return data
  }
}
