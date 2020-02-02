import Foundation

struct FileRoot: Codable {
    let albums: [Album]
}

struct Album: Codable {
    let name: String
    let artist: String
    let publish: String
    let cover: String
    let brief: String
    let songs: [Song]
}

struct Song: Codable {
    let name: String
}
