enum PartOfDay {
    case morning, day, evening, night
    
    static func curent() -> PartOfDay {
        switch getDayTime() {
        case 6..<9: return .morning
        case 9..<18: return .day
        case 18..<21: return .evening
        case 21..<24: return .night
        case 0..<6: return .night
        default:
            assertionFailure()
            return .day
        }
    }
    
    static  func getDayTime() -> Int {
        let time = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        formatter.timeZone = TimeZone.current
        let formatteddate = formatter.string(from: time as Date)
        guard let dayTime = Int(formatteddate) else { return 12 }
        return dayTime
    }
}

import UIKit

class GetPartOfDay {
    
    var backgroundColor: UIColor?
    var textColor: UIColor?
    
    func updateBackgroundColor(){
        switch PartOfDay.curent() {
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
