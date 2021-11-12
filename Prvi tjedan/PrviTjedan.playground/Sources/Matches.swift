import Foundation

public class Matches {
    
    public init() {}
    
    let matchesPerNumbers: Array<Int> = [6, 2, 5, 5, 4, 5, 6, 3, 7, 6]
    var numMatches = 0
    
    public func countMatches(n :Int) {
        
        for i in 0...n {
            
            let iString: String = String(i)
            
            for j in iString {
                let x: String = String(j)
                numMatches += matchesPerNumbers[Int(x) ?? 0]
            }
            
        }
        
        print("The required number of matches for 0 to \(n) is \(numMatches).")
        
    }
    
    
}
