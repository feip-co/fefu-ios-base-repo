import Foundation

struct RegisterBody: Encodable {
    let login: String
    let password: String
    let name: String
    let gender: Int
}

struct LoginBody: Encodable {
    let login: String
    let password: String
}

struct ErrorAPI: Decodable {
    let errors: Dictionary<String, [String]>
}

struct Gender: Decodable {
    let code: Int
    let name: String
}

struct UserModel: Decodable, Identifiable {
    let id: Int
    let name: String
    let login: String
    let gender: Gender
}

struct AuthorizedUser: Decodable {
    let token: String
    let user: UserModel
}
