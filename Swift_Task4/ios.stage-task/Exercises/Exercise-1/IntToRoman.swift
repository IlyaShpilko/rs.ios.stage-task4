import Foundation

public extension Int {
    
    var roman: String? {
        var number = self
        var romanNum = ""
        
        if number <= 0 {
            return nil
        }
        
        let dictionaryConvertNumber = [
            (3900, "MMMCM"),
            (3000, "MMM"),
            (2900, "MMCM"),
            (2000, "MM"),
            (1900, "MCM"),
            (1000, "M"),
            (900, "DM"),
            (500, "D"),
            (400, "CD"),
            (100, "C"),
            (90, "XC"),
            (50, "L"),
            (40, "XL"),
            (10, "X"),
            (9, "IX"),
            (5, "V"),
            (4, "IV"),
            (1, "I")
        ]
        
        for i in dictionaryConvertNumber {
            while number >= i.0 {
                number -= i.0
                romanNum.append(i.1)
            }
        }
        
        return romanNum
    }
}
