import Foundation

extension Date {
    func timeAgo(_ date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full

        return formatter.localizedString(for: self, relativeTo: date)
    }
    
    func interval(_ date: Date) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.month, .day, .hour, .minute, .second]
        formatter.unitsStyle = .full
        
        return formatter.string(from: self, to: date)!
    }

    func clockDisplay() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"

        return formatter.string(from: self)
    }

    func callendarDate() -> Date {
        let calendar = Calendar.current
        let date = calendar.dateComponents([.year, .month, .day], from: self)

        return calendar.date(from: date) ?? self
    }
    
    func callendarDisplay() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMM y"

        return formatter.string(from: self)
    }
}
