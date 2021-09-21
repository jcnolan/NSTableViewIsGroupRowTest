//
//  ExtensionDate.swift
//  MMAutoPost
//
//  Created by JC Nolan on 2/13/19.
//  Copyright © 2019 JC Nolan / Lapin Publishing. All rights reserved.
//

import Foundation

extension Date {
    
    // https://stackoverflow.com/questions/43199635/get-current-time-as-string-swift-3-0/43199769
    
    func toStringDay() -> String {
        
        let date = self
        
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
    
    func toString(format:String="yyyy-MM-dd HH:mm:ss") -> String {
        
        let date = self
        
        // https://stackoverflow.com/questions/43199635/get-current-time-as-string-swift-3-0/43199769
        
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
    
    // https://stackoverflow.com/questions/29465205/how-to-add-minutes-to-current-time-in-swift

    func adding(days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
    
    func adding(hours: Int) -> Date {
        return Calendar.current.date(byAdding: .hour, value: hours, to: self)!
    }
    
    func adding(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }
    
    func adding(seconds: Int) -> Date {
        return Calendar.current.date(byAdding: .second, value: seconds, to: self)!
    }
    
    // https://stackoverflow.com/questions/27182023/getting-the-difference-between-two-nsdates-in-months-days-hours-minutes-seconds
    
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /*
    /// Returns the a custom time interval description from another date - original, magnitude 1 version
    func offsetString(from date: Date") -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
    */
    func offsetString(from date: Date, magnitude:Int = 1, spacer:String = "") -> String {

        var retVal:String = ""
        var level = 0

        enum Durations: CaseIterable { case years, months, weeks, days, hours, minutes, seconds}
        
        let seconds = self.seconds(from: date) % 60
        let minutes = self.minutes(from: date) % 60
        let hours   = self.hours(from: date) % 24
        let days    = self.days(from: date) % 7
        let weeks   = self.weeks(from: date) % 52 // estimated
        let months  = self.months(from: date) % 12
        let years   = self.years(from: date)

        for duration in Durations.allCases
        {
            switch duration {
            case Durations.years    : if (years > 0)    { retVal += "\(years)y\(spacer)"; level += 1 }
            case Durations.months   : if (months > 0)   { retVal += "\(months)M\(spacer)"; level += 1 }
            case Durations.weeks    : if (weeks > 0)    { retVal += "\(weeks)w\(spacer)"; level += 1 }
            case Durations.days     : if (days > 0)     { retVal += "\(days)d\(spacer)"; level += 1 }
            case Durations.hours    : if (hours > 0)    { retVal += "\(hours)h\(spacer)"; level += 1 }
            case Durations.minutes  : if (minutes > 0)  { retVal += "\(minutes)m\(spacer)"; level += 1 } // Will have minutes as lowest if others are there
            case Durations.seconds  : if (seconds > 0)  { retVal += "\(seconds)s"; }
            }
            if level >= magnitude {break}
        }

        return retVal
    }

}
