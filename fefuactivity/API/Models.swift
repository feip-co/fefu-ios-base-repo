import Foundation

struct UserModel: Decodable, Identifiable {
    let id: Int
    let name: String
    let login: String
    let gender: GenderModel
}

struct SocialUserModel: Decodable, Identifiable {
    let id: Int
    let name: String
    let login: String
}

struct ErrorModel: Decodable {
    let message: String
}

struct FieldsErrorModel: Decodable {
    let errors: Dictionary<String, [String]>
}

struct GenderModel: Decodable {
    let name: String
    let code: Int
}

struct LocationModel: Codable {
    let lat: Double
    let lon: Double
}

struct PaginationModel: Decodable {
    let total: Int
    let count: Int
    let perPage: Int
    let currentPage: Int
    let totalPages: Int
}

struct RegisterRequestModel: Encodable {
    let login: String
    let password: String
    let name: String
    let gender: Int
}

struct LoginRequestModel: Encodable {
    let login: String
    let password: String
}

struct LoginErrorModel: Decodable {
    let login: [String]
}

struct AuthResponseModel: Decodable {
    let token: String
    let user: UserModel
}

struct SocialActivitiesRequestModel: Encodable {
    let page: Int
    let perPage: Int
}

struct ActivitiesResponseModel: Decodable {
    let items: [ActivityModel]
    let pagination: PaginationModel
}

struct SocialActivitiesResponseModel: Decodable {
    let items: [SocialActivityModel]
    let pagination: PaginationModel
}

struct ActivityRequestModel: Encodable {
    let startsAt: Date
    let endsAt: Date
    let activityTypeId: Int
    let geoTrack: [LocationModel]
}

struct ActivityModel: Decodable {
    let id: Int
    let createdAt: Date
    let startsAt: Date
    let endsAt: Date
    let activityType: ActivityTypeModel
    let geoTrack: [LocationModel]
}

struct SocialActivityModel: Decodable {
    let id: Int
    let createdAt: Date
    let startsAt: Date
    let endsAt: Date
    let activityType: ActivityTypeModel
    let geoTrack: [LocationModel]
    let user: SocialUserModel
}

struct ActivityTypeModel: Decodable {
    let id: Int
    let name: String
}
