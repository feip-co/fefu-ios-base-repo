import Foundation

class Client: API {
    static func profile(resolve: @escaping((UserModel) -> Void),
                        reject: @escaping((ErrorModel) -> Void)) {

        guard let url = URL(string: rootUrl + "/user/profile") else {
            return
        }

        let request = getRequest(url: url)
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
                    let user = try decoder.decode(UserModel.self, from: data)
                    resolve(user)
                } catch let e {
                    print("Decode error: \(e)")
                }

            case 401:
                do {
                    let error = try decoder.decode(ErrorModel.self, from: data)
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
    
    static func saveActivity(_ data: ActivityRequestModel,
                             resolve: @escaping((ActivitiesResponseModel) -> Void),
                             reject: @escaping((FieldsErrorModel?) -> Void)) {

        guard let url = URL(string: rootUrl + "/user/activities") else {
            return
        }

        let reqData: Data
        do {
            reqData = try encoder.encode(data)
        } catch {
            print("Encode error: \(error)")
            return
        }

        let request = postRequest(url: url, data: reqData)
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
                    let activities = try decoder.decode(ActivitiesResponseModel.self, from: data)
                    
                    resolve(activities)
                } catch let e {
                    print("Decode error: \(e)")
                }

            case 422:
                do {
                    let error = try decoder.decode(FieldsErrorModel.self, from: data)
                    reject(error)
                } catch {
                    print("Decode error: \(error)")
                }
                
            case 401:
                do {
                    let error = try decoder.decode(FieldsErrorModel.self, from: data)
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
