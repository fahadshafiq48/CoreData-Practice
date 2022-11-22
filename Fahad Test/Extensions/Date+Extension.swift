//
//  Data+Extension.swift
//  Fahad Test
//
//  Created by Mac on 15/11/2022.
//

import Foundation

extension Date {
    func convertUtcDateToLocalString(desiredFormat: String) -> String {
        let format = DateFormatter()
        format.locale = Locale(identifier: "en_US_POSIX")
        format.timeZone = .current
        format.dateFormat = desiredFormat
        let dateString = format.string(from: self)
        return dateString
    }
    
    func convertUtcDateToString(desiredFormat: String) -> String {
        let format = DateFormatter()
        format.locale = Locale(identifier: "en_US_POSIX")
        format.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        format.dateFormat = desiredFormat
        let dateString = format.string(from: self)
        return dateString
    }
    
    func getCustomDate(hours: Int, minutes: Int, seconds: Int) -> Date {
        var components = DateComponents()
        components.hour = hours
        components.minute = minutes
        components.second = seconds
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "en_US_POSIX")
        let date = calendar.date(from: components)
        return date!
    }
    
    func startOfSelectedDay() -> Date {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "en_US_POSIX")
        return calendar.startOfDay(for: self)
    }
    
    func endOfSelectedDay() -> Date {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "en_US_POSIX")
        return calendar.date(bySettingHour: 23, minute: 59, second: 59, of: self)!
    }
    
    func getFromTime() -> String {
        if self == Date() {
            
        }
        return ""
    }
    
    var dayNameFull: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self as Date)
    }
    
    var currentDateWithTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MMMM dd yyyy hh:mm:ss.SSSS"
        return dateFormatter.string(from: self)
    }
    
    func localDate() -> Date {
        let nowUTC = Date()
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "en_US_POSIX")
        guard let localDate = calendar.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC) else {
            return Date().inEnglish()
        }

        return localDate
    }
    
    func startOfMonth() -> Date {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "en_US_POSIX")
        return calendar.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "en_US_POSIX")
        return calendar.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    func inEnglish() -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.date(from: self.convertUtcDateToString(desiredFormat: Constants.kApiDateTimeFormat)) ?? self
    }
    
    func getMinutesDifferenceFromTwoDates(end: Date) -> Int {
           let diff = Int(end.timeIntervalSince1970 - self.timeIntervalSince1970)
           let hours = diff / 3600
           let minutes = (diff - hours * 3600) / 60
           return minutes
       }
}

/**
 *  Extends the NSDate class by adding convenient methods to display the passage of
 *  time in String format.
 */
public extension Date {
    func timeAgo() -> String {
        let now = Date()
        let earliest = (now as NSDate).earlierDate(self) as Date
        let latest = (earliest == now) ? self : now
        
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "en_US_POSIX")
        let unitFlags: NSCalendar.Unit = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
        let components = (calendar as NSCalendar).components(unitFlags, from: earliest, to: latest, options: [])
        
        if let year = components.year, year > 0 {
            return "\(year) yr\(year == 1 ? "" : "s") ago"
        }
        
        if let month = components.month, month > 0 {
            return "\(month) mo\(month == 1 ? "" : "s") ago"
        }
        
        if let week = components.weekOfYear, week > 0 {
            return "\(week) wk\(week == 1 ? "" : "s") ago"
        }
        
        if let day = components.day, day > 0 {
            return "\(day) day\(day == 1 ? "" : "s") ago"
        }
        
        if let hour = components.hour, hour > 0 {
            return "\(hour) hr\(hour == 1 ? "" : "s") ago"
        }
        
        if let minute = components.minute, minute > 0 {
            return "\(minute) min\(minute == 1 ? "" : "s") ago"
        }
        
        if let second = components.second, second > 0 {
            return "\(second) sec\(second == 1 ? "" : "s") ago"
        }
        
        return "just now"
        
    }
        
    func timeAgoSinceDate() -> String {

        let timeAgoSinceDate: String
        if let interval = Calendar.current.dateComponents([.year], from: self, to: Date()).year, interval > 0 { // Year
            timeAgoSinceDate = interval == 1 ? "1 year ago" : "\(interval) years ago"
        } else if let interval = NSCalendar.current.dateComponents([.month], from: self, to: Date()).month, interval > 0 { // Month
            timeAgoSinceDate = interval == 1 ? "1 month ago" : "\(interval) months ago"
        } else if let interval = NSCalendar.current.dateComponents([.day], from: self, to: Date()).day, interval > 0 { // Day
            timeAgoSinceDate = interval == 1 ? "1 day ago" : "\(interval) days ago"
        } else if let interval = NSCalendar.current.dateComponents([.hour], from: self, to: Date()).hour, interval > 0 { // Hours
            timeAgoSinceDate = interval == 1 ? "1 hour ago" : "\(interval) hours ago"
        } else if let interval = NSCalendar.current.dateComponents([.minute], from: self, to: Date()).minute, interval > 0 { // Minute
            timeAgoSinceDate = interval == 1 ? "1 minute ago" : "\(interval) minutes ago"
        } else { // Default
            timeAgoSinceDate = "just now"
        }
        
        return timeAgoSinceDate
    }
    
    func timeAgoShortStr() -> String {
        let now = Date()
        let earliest = (now as NSDate).earlierDate(self) as Date
        let latest = (earliest == now) ? self : now
        
        let calendar = Calendar.current
        let unitFlags: NSCalendar.Unit = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
        let components = (calendar as NSCalendar).components(unitFlags, from: earliest, to: latest, options: [])
        
        if let year = components.year, year > 0 {
            return "\(year)y"
        }
        
        if let month = components.month, month > 0 {
            return "\(month)month"
        }
        
        if let week = components.weekOfYear, week > 0 {
            return "\(week)w"
        }
        
        if let day = components.day, day > 0 {
            return "\(day)d"
        }
        
        if let hour = components.hour, hour > 0 {
            return "\(hour)h"
        }
        
        if let minute = components.minute, minute > 0 {
            return "\(minute)m"
        }
        
        if let second = components.second, second > 0 {
            return "\(second)s"
        }
        
        return "just now"
        
    }
    
}

extension Date {
    var ISOString: String {
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter.string(from: self)
    }
    
    func string(fromFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        return dateFormatter.string(from: self)
    }
    
    var currentTimeMillis: Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}

extension Date {
    func isInSameWeek(date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .weekOfYear)
    }
    func isInSameMonth(date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .month)
    }
    func isInSameYear(date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .year)
    }
    func isInSameDay(date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .day)
    }
    var isInThisWeek: Bool {
        return isInSameWeek(date: Date())
    }
    var isInYesterday: Bool {
        return Calendar.current.isDateInYesterday(self)
    }
    var isInToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    var isInTheFuture: Bool {
        return Date() < self
    }
    var isInThePast: Bool {
        return self < Date()
    }
}
