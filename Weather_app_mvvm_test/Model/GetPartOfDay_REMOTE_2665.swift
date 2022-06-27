enum PartOfDay {
    case morning, day, evening, night
}

import UIKit

class GetPartOfDay: UIViewController {
    
    var backgroundColor: UIColor?
    var textColor: UIColor?
    
    func getDayTime() -> Int {
        let time = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        formatter.timeZone = TimeZone.current
        let formatteddate = formatter.string(from: time as Date)
        guard let dayTime = Int(formatteddate) else { return 12}
        return dayTime
    }
    
    func getPartOfDay(fromHour hour: Int) -> PartOfDay {
        let dayTime = getDayTime()
        
        if dayTime >= 6 && dayTime < 9  { return .morning }
        if dayTime >= 9 && dayTime < 18 { return .day }
        if dayTime >= 18 && dayTime < 21 { return .evening }
        if dayTime >= 21 && dayTime < 24 || hour < 6 { return .night }
        return .day
    }
    
    func updateBackgroundColor(){
        switch getPartOfDay(fromHour: getDayTime() ) {
        case .morning: self.backgroundColor = UIColor(red: 60.0/255.0, green: 132.0/255.0, blue: 165.0/255.0, alpha: 1.0)
            textColor = .white.withAlphaComponent(0.7)
        case .day: self.backgroundColor = UIColor(red: 89.0/255.0, green: 201.0/255.0, blue: 234.0/255.0, alpha: 1.0)
            textColor = .black
        case .evening: self.backgroundColor = UIColor(red: 105.0/255.0, green: 132.0/255.0, blue: 165.0/255.0, alpha: 1.0)
            textColor = .white.withAlphaComponent(0.7)
        case .night: self.backgroundColor = UIColor(red: 35.0/255.0, green: 62.0/255.0, blue: 95.0/255.0, alpha: 1.0)
            textColor = .white.withAlphaComponent(0.7)
        }
    }
    
    
}
