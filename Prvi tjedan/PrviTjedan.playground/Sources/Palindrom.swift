import Foundation

public class Palindrom {
    
    public init() {}
    
    public func checkPalindrom(string: String) -> String {
        let palindrom = string.lowercased().replacingOccurrences(of: " ", with: "")
        let length = palindrom.count/2
        
        for i in 0..<length {
                
            let start = palindrom.index(palindrom.startIndex, offsetBy: i)
            let end = palindrom.index(palindrom.endIndex, offsetBy: -1-i)
            
            if palindrom[start] != palindrom[end]{
                return "Input value \(palindrom) is not a palindrom"
            }
        }
        
        return "Input value \(palindrom) is a palindrom!"
    
    }
}
