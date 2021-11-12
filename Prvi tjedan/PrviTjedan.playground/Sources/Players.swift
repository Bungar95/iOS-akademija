import Foundation

public class Players {
    
    public init() {}
    
    public func countN(n :Int){
        
        var clockwise = true
        var player = 0
        var i = 1
        
        while i < n {
            
            if i%7==0 {
                clockwise = changeDirection(direction: clockwise)
            }else if i%13==0{
                player = changePlayer(direction: clockwise, player: player)
            }
            
            player = changePlayer(direction: clockwise, player: player)
            i += 1
        }
        
        print("The game finished on player #\(player)")
        
    }
    
    func changePlayer(direction: Bool, player: Int) -> Int{
        
        var currentPlayer = player
        
        if direction {
            currentPlayer += 1
        }else{
            currentPlayer -= 1
        }
        
        if currentPlayer == 11 {
            currentPlayer = 1
        }else if currentPlayer == 0 {
            currentPlayer = 10
        }
        
        return currentPlayer
        
    }
    
    func changeDirection(direction: Bool) -> Bool{
        return !direction
    }
    
}
