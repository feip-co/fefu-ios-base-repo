import Foundation

class Activities: API {
    static let groupUrl: String = rootUrl

    static func types(resolve: @escaping(([ActivityCollectionCellModel]) -> Void),
                      reject: @escaping((ErrorModel) -> Void)) {

        guard let url = URL(string: groupUrl + "/activity_types") else {
            return
        }

        let request = super.getRequest(url: url)
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
                    let types = try super.decoder.decode([ActivityCollectionCellModel].self, from: data)
                    resolve(types)
                } catch let e {
                    print("Decode error: \(e)")
                }

            case 422:
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

    static func activities(resolve: @escaping((SocialActivitiesResponseModel) -> Void),
                           reject: @escaping((FieldsErrorModel?) -> Void)) {

        guard let url = URL(string: groupUrl + "/activities") else {
            return
        }

        let request = super.getRequest(url: url)
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
                    let types = try super.decoder.decode(SocialActivitiesResponseModel.self, from: data)
                    resolve(types)
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
}

