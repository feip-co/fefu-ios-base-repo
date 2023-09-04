import Foundation

extension TimeInterval {
    func duration() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.month, .day, .hour, .minute, .second]
        formatter.unitsStyle = .full

        return formatter.string(from: TimeInterval(self))!
    }
}
