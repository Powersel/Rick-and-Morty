import Foundation

public enum RMError: Error {
  case invalidUrl
  case invalidResponse
  case parsingFailed
  case noData
  case networkError(Error)
  
  var localizedDescription: String {
    switch self {
    case .parsingFailed: return "Model parsing error."
    case .networkError: return "API error network."
    default: return "Some unknown error"
    }
  }
}
