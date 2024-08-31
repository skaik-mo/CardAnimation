//
//  Date.swift
//  CardAnimation
//
//  Created by Mohammed Skaik on 30/08/2024.
//

import Foundation

extension Date {

    var _stringDate: String {
        return self._string(dataFormat: "MMM d")
    }
    
    func _string(dataFormat: String, timeZone: String = TimeZone.current.identifier) -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar.init(identifier: .gregorian)
        formatter.dateFormat = dataFormat
        formatter.timeZone = TimeZone.init(identifier: timeZone)
        formatter.locale = Locale(identifier: "en")
        return formatter.string(from: self)
    }

    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
         return calendar.dateComponents(Set(components), from: self)
     }
    
    func compare(previousDate: Date) -> Bool {
        let _currentDate = self.get(.day, .month, .month)
        let _previousDate = previousDate.get(.day, .month, .month)
        return _currentDate.day == _previousDate.day
    }

    /// Returns a Date with the specified amount of components added to the one it is called with
    func _add(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date {
        let components = DateComponents(year: years, month: months, day: days, hour: hours, minute: minutes, second: seconds)
        return Calendar.current.date(byAdding: components, to: self) ?? Date()
    }
}
