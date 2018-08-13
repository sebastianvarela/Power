import Foundation

public extension Date {
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
    
    public var formattedSpanishDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let converted = dateFormatter.string(from: self)
        return converted
    }
    
    public func formattedShortDateString(locale: Locale? = nil) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        dateFormatter.locale = locale ?? PowerBag.shared.userDefinedLocale.value
        let converted = dateFormatter.string(from: self)
        return converted.lowercased()
    }
    
    public func formattedShortDateTimeString(locale: Locale? = nil) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM ● HH:mm"
        dateFormatter.locale = locale ?? PowerBag.shared.userDefinedLocale.value
        let converted = dateFormatter.string(from: self)
        return converted.lowercased()
    }
    
    public func formattedMonthYearString(locale: Locale? = nil) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        dateFormatter.locale = locale ?? PowerBag.shared.userDefinedLocale.value
        let converted = dateFormatter.string(from: self)

        return converted.capitalized
    }
    
    public func totalDays(from date: Date) -> Int {
        if self < date {
            return 0
        }
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
}

public func - (lhs: Date, rhs: Date) -> TimeInterval {
    return lhs.timeIntervalSince(rhs)
}
