//
//  Date+Extension.swift
//  Signup
//
//  Created by seongha shin on 2022/03/29.
//

import Foundation

extension Date {
    
    /// 날짜를 원하는 포맷 형태로 변환
    func string(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    /// 현재 날짜의 일 리턴
    func day() -> Int? {
        Calendar.current.dateComponents([.day], from: self).day
    }
    
    /// 현재 날짜에 day를 더함
    func addDay(_ day: Int) -> Date? {
        Calendar.current.date(byAdding: DateComponents(day: day), to: self)
    }
    
    /// 현재 Date에 month를 더함
    func addMonth(_ month: Int) -> Date? {
        Calendar.current.date(byAdding: DateComponents(month: month), to: self)
    }
    
    /// 현재 월의 1일을 리턴
    func firstDayOfMonth() -> Date? {
        let components = Calendar.current.dateComponents([.year, .month], from: self)
        return Calendar.current.date(from: components)
    }
    
    /// 현재 월의 마지막 일을 리턴
    func lastDayOfMonth() -> Date? {
        guard let firstDay = firstDayOfMonth() else { return nil }
        
        guard let nextMonth = Calendar.current.date(byAdding: .month, value: +1, to: firstDay) else {
            return nil
        }
        
        return Calendar.current.date(byAdding: .day, value: -1, to: nextMonth)
    }
    
    /// 현재 날짜와 다른날짜의 일차를 리턴
    func numberOfDaysBetween(to date: Date) -> Int {
        let fromDate = self > date ? date : self
        let toDate = self > date ? self : date
        
        let numberOfDays = Calendar.current.dateComponents([.day], from: fromDate, to: toDate)
        
        guard let days = numberOfDays.day else { return 0 }
        return days
    }
    
    /// 현재 날짜와 다른날짜 사이의 Date를 리턴
    func daysBetween(to date: Date) -> [Date] {
        let numberOfDaysBetween = self.numberOfDaysBetween(to: date)
        return (0...numberOfDaysBetween).compactMap { addDay in
            self.addDay(addDay)
        }
    }
    
    /// 현재 월의 일수를 리턴
    /// - parameter withWeekDay: 현재 월의 일수 외 앞뒤의 빈 여백일(weekday)에 맞춰 여백을 넣어서 리턴
    func DaysOfMonth(withWeekDay: Bool = false) -> [Date?] {
        guard let firstDayDate = firstDayOfMonth(),
              let lastDayDate = lastDayOfMonth() else {
            return []
        }

        let startComponents = Calendar.current.dateComponents([.day, .weekday], from: firstDayDate)
        let lastComponents = Calendar.current.dateComponents([.day, .weekday], from: lastDayDate)
        
        guard let startWeekDay = startComponents.weekday,
              let lastDay = lastComponents.day,
              let lastWeekDay = lastComponents.weekday else {
            return []
        }
        
        var days = (0..<lastDay).map { firstDayDate.addDay($0) }
        
        if withWeekDay == false {
            return days
        }
        
        (0..<startWeekDay - 1).forEach { _ in days.insert(nil, at: 0) }
        (lastWeekDay - 1..<6).forEach { _ in days.append(nil) }
        
        return days
    }
}
