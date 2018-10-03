import Foundation

public extension Date {
    public init?(iso8601String: String) {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withFullTime, .withFullDate, .withTimeZone, .withColonSeparatorInTimeZone]
        guard let date = dateFormatter.date(from: iso8601String) else {
            return nil
        }
        self = date
    }
    
    public func dateByAdding(years: Int) -> Date {
        guard let newDate = Calendar.current.date(byAdding: DateComponents(year: years), to: self) else {
            fatalError("Cannot add \(years) years to date \(self)")
        }
        return newDate
    }
    
    public func dateByAdding(days: Int) -> Date {
        guard let newDate = Calendar.current.date(byAdding: DateComponents(day: days), to: self) else {
            fatalError("Cannot add \(days) days to date \(self)")
        }
        return newDate
    }
    
    public func dateByAdding(months: Int) -> Date {
        guard let newDate = Calendar.current.date(byAdding: DateComponents(month: months), to: self) else {
            fatalError("Cannot add \(months) months to date \(self)")
        }
        return newDate
    }
    
    public func dateByAdding(hours: Int) -> Date {
        guard let newDate = Calendar.current.date(byAdding: DateComponents(hour: hours), to: self) else {
            fatalError("Cannot add \(hours) hours to date \(self)")
        }
        return newDate
    }
    
    public func dateByAdding(minutes: Int) -> Date {
        guard let newDate = Calendar.current.date(byAdding: DateComponents(minute: minutes), to: self) else {
            fatalError("Cannot add \(minutes) minutes to date \(self)")
        }
        return newDate
    }
    
    public func formattedSpanishDateString(timeZone: TimeZone? = nil) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = timeZone ?? PowerBag.shared.timeZone.value
        let converted = dateFormatter.string(from: self)
        return converted
    }
    
    public func formattedShortDateString(locale: Locale? = nil, timeZone: TimeZone? = nil) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        dateFormatter.locale = locale ?? PowerBag.shared.locale.value
        dateFormatter.timeZone = timeZone ?? PowerBag.shared.timeZone.value
        let converted = dateFormatter.string(from: self)
        return converted.lowercased()
    }
    
    public func formattedShortDateTimeString(locale: Locale? = nil, timeZone: TimeZone? = nil) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM ● HH:mm"
        dateFormatter.locale = locale ?? PowerBag.shared.locale.value
        dateFormatter.timeZone = timeZone ?? PowerBag.shared.timeZone.value
        let converted = dateFormatter.string(from: self)
        return converted.lowercased()
    }
    
    public func formattedMonthYearString(locale: Locale? = nil, timeZone: TimeZone? = nil) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        dateFormatter.locale = locale ?? PowerBag.shared.locale.value
        dateFormatter.timeZone = timeZone ?? PowerBag.shared.timeZone.value
        let converted = dateFormatter.string(from: self)
        return converted.capitalized
    }
    
    public func iso8601String(utc: Bool, timeZone: TimeZone? = nil) -> String {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withFullTime, .withFullDate, .withTimeZone, .withColonSeparatorInTimeZone]
        if utc {
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        } else {
            dateFormatter.timeZone = timeZone ?? PowerBag.shared.timeZone.value
        }
        let converted = dateFormatter.string(from: self)
        return converted
    }
    
    public func totalDays(from date: Date) -> Int {
        if self < date {
            return Calendar.current.dateComponents([.day], from: self, to: date).day ?? 0
        }
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
}

public func - (lhs: Date, rhs: Date) -> TimeInterval {
    return lhs.timeIntervalSince(rhs)
}
