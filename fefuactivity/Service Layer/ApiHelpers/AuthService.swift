import Foundation


class AuthService {
    static let decoder = JSONDecoder()
    static let encoder = JSONEncoder()
    
    init() {
        AuthService.decoder.keyDecodingStrategy = .convertFromSnakeCase
        AuthService.encoder.keyEncodingStrategy = .convertToSnakeCase
    }
    
    static func register(_ body: Data,
                         completion: @escaping ((AuthorizedUser) -> Void),
                         onError :@escaping((ErrorAPI) -> Void)) {
        
        guard let url = URL(string: "https://fefu.t.feip.co/api/auth/register") else {
            print("Битая ссылка")
            return
        }
        
        var urlReq = URLRequest(url: url)
        urlReq.httpMethod = "POST"
        urlReq.httpBody = body
        urlReq.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlReq.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlReq) { data, response, error in
            
            guard let data = data else {
                return
            }
            
            if let res = response as? HTTPURLResponse {
                if res.statusCode == 201 {
                    do {
                        let user = try AuthService.decoder.decode(AuthorizedUser.self, from: data)
                        completion(user)
                        return
                    } catch {
                        print(error)
                    }
                }
                
                if res.statusCode == 422 {
                    do {
                        let err = try AuthService.decoder.decode(ErrorAPI.self, from: data)
                        onError(err)
                        return
                    } catch {
                        print(error)
                    }
                }
            }
        }
        task.resume()
    }
    
    static func login(_ body: Data,
                      completion: @escaping ((AuthorizedUser) -> Void),
                      onError :@escaping((ErrorAPI) -> Void)) {
        
        guard let url = URL(string: "https://fefu.t.feip.co/api/auth/login") else {
            print("Битая ссылка")
            return
        }
        
        var urlReq = URLRequest(url: url)
        urlReq.httpMethod = "POST"
        urlReq.httpBody = body
        urlReq.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlReq.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlReq) { data, response, error in
            
            guard let data = data else {
                return
            }
            
            if let res = response as? HTTPURLResponse {
                if res.statusCode == 200 {
                    do {
                        let user = try AuthService.decoder.decode(AuthorizedUser.self, from: data)
                        completion(user)
                        return
                    } catch {
                        print(error)
                    }
                }
                if res.statusCode == 422 {
                    do {
                        let err = try AuthService.decoder.decode(ErrorAPI.self, from: data)
                        onError(err)
                        return
                    } catch {
                        print(error)
                    }
                }
            }
        }
        task.resume()
    }
}
