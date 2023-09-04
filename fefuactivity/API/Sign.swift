import Foundation

class Sign: API {
    static let groupUrl: String = rootUrl + "/auth"

    static func register(_ data: Data,
                         resolve: @escaping((AuthResponseModel) -> Void),
                         reject: @escaping((FieldsErrorModel) -> Void)) {

        guard let url = URL(string: groupUrl + "/register") else {
            return
        }

        let request = super.postRequest(url: url, data: data)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                return
            }

            guard let res = response as? HTTPURLResponse else {
                return
            }

            switch res.statusCode {
            case 201:
                do {
                    let authResponse = try super.decoder.decode(AuthResponseModel.self, from: data)
                    resolve(authResponse)
                } catch let e {
                    print("Decode error: \(e)")
                }

            case 422:
                do {
                    let error = try super.decoder.decode(FieldsErrorModel.self, from: data)
                    reject(error)
                } catch {
                    print("Decode error: \(error)")
                }

            default:
                break
            }
        }
        task.resume()
    }
    
    static func login(_ data: Data,
                      resolve: @escaping((AuthResponseModel) -> Void),
                      reject: @escaping((FieldsErrorModel) -> Void)) {

        guard let url = URL(string: groupUrl + "/login") else {
            return
        }

        let request = super.postRequest(url: url, data: data)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                return
            }

            guard let res = response as? HTTPURLResponse else {
                return
            }

            switch res.statusCode {
            case 200:
                do {
                    let authResponse = try super.decoder.decode(AuthResponseModel.self, from: data)
                    resolve(authResponse)
                } catch let e {
                    print("Decode error: \(e)")
                }

            case 422:
                do {
                    let error = try super.decoder.decode(FieldsErrorModel.self, from: data)
                    reject(error)
                } catch {
                    print("Decode error: \(error)")
                }

            default:
                break
            }
        }
        task.resume()
    }
    
    static func logout(resolve: @escaping(() -> Void),
                       reject: @escaping((ErrorModel) -> Void)) {

        guard let url = URL(string: groupUrl + "/logout") else {
            return
        }

        let request = super.postRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                return
            }

            guard let res = response as? HTTPURLResponse else {
                return
            }

            switch res.statusCode {
            case 200:
                resolve()

            case 401:
                do {
                    let error = try super.decoder.decode(ErrorModel.self, from: data)
                    reject(error)
                } catch {
                    print("Decode error: \(error)")
                }

            default:
                break
            }
        }
        task.resume()
    }

    static func errorMessage(error: FieldsErrorModel) -> String {
        return error.errors.map { (_: String, value: [String]) in
            value.joined(separator: "\n")
        }.joined(separator: "\n")
    }
}
