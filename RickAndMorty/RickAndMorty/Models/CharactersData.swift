import Foundation

struct RMCharactersData: Codable {
  let info: ServiceDataInfo
  let characters: [RMCharacter]
  
  enum CodingKeys: String, CodingKey {
    case info
    case characters = "results"
  }
}

//enum RMCharacterStatus: String, Codable, CaseIterable {
//  case alive
//  case dead
//  case unknown
//
//  enum CodingKeys: String, CodingKey {
//      case alive = "Alive"
//      case dead = "Dead"
//      case unknown = "unknown"
//  }
//}
//
//enum RMSpecies: String, Codable, CaseIterable {
//  case human = "Human"
//  case alien = "Alien"
//}

struct RMCharacter: Codable {
  let id: Int
  let name: String
//  let species: RMSpecies
//  let imageUrl: String
//  let status: RMCharacterStatus
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
//    case status
//    case species
//    case imageUrl = "image"
  }
}
