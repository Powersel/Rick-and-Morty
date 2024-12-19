import Foundation

struct RMCharactersData: Decodable {
  let info: ServiceDataInfo
  let results: [RMCharacter]
}

struct RMCharacter: Decodable {
  let id: Int
  let name: String
  let image: String
}
