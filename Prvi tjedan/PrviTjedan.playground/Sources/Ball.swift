import Foundation

public class Ball {
    
    public init() {}
    
    var motherViewCounter = 0
    
    let decreaseHeight:(Double, Double) -> (Double) = { (h, x) in
        print("Ball bounced back to \(h-x).")
        return h-x
    }
    
    public func countBallAppeareances(height h: Double, decrease x: Double){
        
        var height: Double = h
        let decrease: Double = x
        
        if height == 0 && height < 0 {
            print("Height value needs to be larger than 0.")
            return
        }
        
        while height > 0 {
            
            motherViewCounter = checkMother(h: height, mother: motherViewCounter)
            height = decreaseHeight(height, decrease)
            
        }
        
        print("Result: \(motherViewCounter)")
        print("Result for both falling and bouncing back in front of window: \(motherViewCounter*2+1)")
    }
    
    func checkMother(h: Double, mother: Int) -> Int {
        
        if h >= 1.5 {
            print("Mother saw the ball.")
            return mother+1
        }else{
            return mother
        }
    }
    
}
