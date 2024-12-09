import Foundation

struct ServiceDataInfo: Codable {
  let count: Int
  let pages: Int
  let next: String?
  let prev: String?
}
