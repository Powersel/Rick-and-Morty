import Foundation

enum APIEndpoint {
  case characters
  case locations
  case episodes
}

extension APIEndpoint {
  private var baseURL: String { return "https://rickandmortyapi.com/api" }
  
  var path: String {
    switch self {
    case .characters: return baseURL + "/character"
    case .locations: return baseURL + "/location"
    case .episodes: return baseURL + "/episode"
    }
  }
}
