import Foundation

public class Bank {
    
    public init() {}
    
    public func playGame(bankNumber: String?, account: String?, client: String?) -> Int {
        
        guard let safeBankNumber = bankNumber else { return 0}
        guard let safeAccount = account else { return 0}
        guard let safeClient = client else { return 0}
        
        guard let intBankNumber = Int(safeBankNumber) else { return 0}
        guard let lastDigits = takeOutLastDigits(bankNumber: safeBankNumber) else { return 0}
        
        return gameResult(bankNumber: intBankNumber, lastDigits: lastDigits, account: safeAccount.lowercased(), client: safeClient.lowercased())
        
    }
    
    func takeOutLastDigits(bankNumber: String) -> Int? {
        
        let start = bankNumber.index(bankNumber.endIndex, offsetBy: -3)
        let end = bankNumber.index(before: bankNumber.endIndex)
        let range = start...end
        return Int(bankNumber[range])
        
    }
    
    func gameResult(bankNumber: Int, lastDigits: Int, account: String, client: String) -> Int {
        
        print(bankNumber)
        
        if bankNumber % 6 == 0 {
            print("Ajoj, račun je djeljiv sa 6, račun Vam je od ovog trenutka trajno blokiran. Pozdrav.")
            return 1
        }
        
        if client == "privatni" && account == "žiro" {
            print("Banka Vam daruje milijun kuna! Samo nam pošaljite broj kreditne i PIN :)")
            return 2
        }
        
        if client == "fizički" && lastDigits % 3 == 0 {
            print("Banka Vam daje poticaj od milijun eura!")
            return 3
        }
        
        print("Više sreće drugi put!")
        return 4
    }
    
}

