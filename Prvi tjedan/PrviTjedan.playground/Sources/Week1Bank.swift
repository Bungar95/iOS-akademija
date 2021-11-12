import Foundation

public class Week1Bank {
    
    public init() {}
    
    public enum Account: String {
       case devizni = "devizni"
       case ziro = "žiro"
       case tekuci = "tekući"
    }
    
    public enum Client: String {
        case privatni = "privatni"
        case fizicki = "fizički"
    }
    
    public func playGame(bankNumber: String, account: Account, client: Client){
        
        if !verifyNumber(number: bankNumber) {
            return
        }
        
        guard let intBankNumber = Int(bankNumber) else { return }
        guard let lastDigits = takeOutLastDigits(bankNumber: bankNumber) else { return }
        
        gameResult(bankNumber: intBankNumber, lastDigits: lastDigits, account: account, client: client)
        
    }
    
    func verifyNumber(number: String) -> Bool {
        
        if number.count == 10 && number.first == "0" && number[number.index(after: number.startIndex)] == "4" {
            return true
        }else{
            print("Broj računa nije ispravan.")
            return false
        }
    }
    
    func takeOutLastDigits(bankNumber: String) -> Int? {
        
        let start = bankNumber.index(bankNumber.endIndex, offsetBy: -3)
        let end = bankNumber.index(before: bankNumber.endIndex)
        let range = start...end
        return Int(bankNumber[range])
        
    }
    
    func gameResult(bankNumber: Int, lastDigits: Int, account: Account, client: Client){
        
        if bankNumber % 6 == 0 {
            print("Ajoj, račun je djeljiv sa 6, račun Vam je od ovog trenutka trajno blokiran. Pozdrav.")
            return
        }
        
        if client.rawValue == "privatni" && account.rawValue == "žiro" {
            print("Banka Vam daruje milijun kuna! Samo nam pošaljite broj kreditne i PIN :)")
            return
        }
        
        if client.rawValue == "fizički" && lastDigits % 3 == 0 {
            print("Banka Vam daje poticaj od milijun eura!")
            return
        }
        
        print("Više sreće drugi put!")
    }
    
}
