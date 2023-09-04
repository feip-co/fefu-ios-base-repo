import Foundation

class AuthService: APIService {
    static let groupUrl: String = baseUrl + "/auth"

    

    static func errorMessage(error: FieldsErrorModel) -> String {
        return error.errors.map { (_: String, value: [String]) in
            value.joined(separator: "\n")
        }.joined(separator: "\n")
    }
}
