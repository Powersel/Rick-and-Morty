import Foundation

struct ServiceDataInfo: Decodable {
  let count: Int
  let pages: Int
  let next: String?
  let prev: String?
}
