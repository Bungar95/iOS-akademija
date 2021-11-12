//
//  Classes.swift
//  Predavanja
//
//  Created by Borna Ungar on 14.06.2021..
//

import Foundation

public class Classes {
    
    public init() {}
    
    let classStart = 8*60
    let classEnd = 16*60
    let classLength = 45
    var smallBreakCounter = 0
    var classCounter = 0
    var classPending = true
    
    var stringArray: Array<String> = []
    var intArray: Array<Int> = []
    
    public func classAlgorithm(smallBreakLength: Int, bigBreakLength: Int,
                               bigBreakAppointment: Int, inputTime: String) -> String {
        
        let inputTime = checkValidTime(input: inputTime)
        
        processClass(smallBreak: smallBreakLength, bigBreak: bigBreakLength, bigBreakAppointment: bigBreakAppointment)
        return findInputTime(inputTime: inputTime)
    }
    
    func checkValidTime(input: String) -> Int {
        
        let input = input.replacingOccurrences(of: " ", with: "").split(separator: ":")
        guard let zadanoH = Int(input[0]) else {
            print("Ne radi unešen sat")
            return 0
        }
        guard let zadanoMin = Int(input[1]) else {
            print("Ne rade unešene minute")
            return 0
        }
        
        let inputTime = zadanoH*60 + zadanoMin
        
        if inputTime >= classStart && inputTime <= classEnd {
            return inputTime
        } else {
            print("Unešeno vrijeme se nalazi izvan termina kolegija.")
            return 0
        }
    }
    
    func processClass(smallBreak: Int, bigBreak: Int, bigBreakAppointment: Int){
        
        var i = classStart
        
        while i < classEnd {
            
            if classPending {
                classCounter += 1
                stringArray.append("sat #\(classCounter)")
                i += classLength
            }else{
                if checkBigBreak(appointment: bigBreakAppointment) {
                    stringArray.append("veliki odmor")
                    i += bigBreak
                } else {
                    smallBreakCounter += 1
                    stringArray.append("mali odmor #\(smallBreakCounter)")
                    i += smallBreak
                }
            }
            
            intArray.append(i)
            changeActivityStatus()
        }
    }
    
    func findInputTime(inputTime: Int) -> String {
        
        for i in 0...stringArray.count{
            if intArray[i] > inputTime {
                return "Zadano vrijeme: \(stringArray[i])"
            }
        }
        return "Nešto ne radi."
    }
    
    func checkBigBreak(appointment: Int) -> Bool {
        if classCounter == appointment {
            return true
        } else {
            return false
        }
    }
    
    func changeActivityStatus(){
        classPending = !classPending
    }
    
}

