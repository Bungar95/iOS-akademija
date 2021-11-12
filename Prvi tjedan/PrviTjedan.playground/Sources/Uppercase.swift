import Foundation

public class Uppercase {
    
    public init() {}
    
    public func applyUpperLowercase(string: String) {
        
        var string1: String = ""
        var string2: String = ""
        
        for (n, c) in string.enumerated() {
            if n % 2 == 0 {
                string1.append(c.uppercased())
                string2.append(c.lowercased())
            }else{
                string1.append(c.lowercased())
                string2.append(c.uppercased())
            }
        }
        
        print(string1)
        print(string2)
    }
    
}
