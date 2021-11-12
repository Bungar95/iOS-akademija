import Foundation

public class IntSum {
    
    public init() {}
    
    public func sumMinIntegers(array: Array<Int>){
        
        let sortedArray = array.sorted()
        
        if array.count < 4 {
            print("At least 4 integers needed.")
        } else {
            print("Sum of 2 lowest ints is  \(sortedArray[0]+sortedArray[1])")
        }
    }
    
}
