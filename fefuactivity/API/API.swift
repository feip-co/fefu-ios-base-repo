import Foundation

class API {
    static let rootUrl: String = "https://fefu.t.feip.co/api"
    
    static let decoder: JSONDecoder = ({
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .custom { decoder in

            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)

            let dateFormatter = ISO8601DateFormatter()
            guard let date = dateFormatter.date(from: dateString) else {
                throw DecodingError.dataCorruptedError(in: container,
                    debugDescription: "Cannot decode date string \(dateString)")
            }
            
            return date
        }

        return decoder
    })()
    static let encoder: JSONEncoder = ({
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        encoder.dateEncodingStrategy = .formatted(dateFormatter)

        return encoder
    })()
    
    static func createRequest(_ url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        if let token = UserDefaults.standard.string(forKey: "token") {
            request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        }

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        return request
    }

    static func postRequest(url: URL, data: Data? = nil) -> URLRequest {
        var request = self.createRequest(url)
        request.httpMethod = "POST"
        request.httpBody = data

        return request
    }

    static func getRequest(url: URL, data: Data? = nil) -> URLRequest {
        var request = self.createRequest(url)

        request.httpMethod = "GET"
        request.httpBody = data

        return request
    }
    
    static func errorMessage(error: ErrorModel) -> String {
        return error.message
    }
}
