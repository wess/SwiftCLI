//
//  Input.swift
//  Example
//
//  Created by Jake Heiser on 8/17/14.
//  Copyright (c) 2014 jakeheis. All rights reserved.
//

public class Input {
    
    //  MARK: - Public
    
    /**
        Awaits a string of input
        - Parameter message: message to be printed before accepting input (e.g. "Name: ")
    */
    public static func awaitInput(message: String?) -> String {
        var input: String? = nil
        while input == nil {
            if let message = message {
                var printMessage = message
                if !printMessage.hasSuffix(" ") && !printMessage.hasSuffix("\n") {
                    printMessage += " "
                }
                print(printMessage, terminator: "")
            }
            input = readLine()
        }
        
        return input!
    }
    
    /**
        Awaits a string of valid input; continues accepting input until the given input is determined to be valid
        - Parameter message: message to be printed before accepting input (e.g. "Name: ")
        - Parameter validation: closure evaluating whether the given input was valid
    */
    public static func awaitInputWithValidation(message: String?, validation: (_ input: String) -> Bool) -> String {
        while (true) {
            let str = awaitInput(message: message)
            
            if validation(str) {
                return str
            } else {
                print("Invalid input")
            }
        }
    }
    
    /**
        Awaits a string of convertible input; continues accepting input until the given input is successfully converted
        - Parameter message: message to be printed before accepting input (e.g. "Name: ")
        - Parameter conversion: closure attempting to convert the input to the desired output
    */
    public static func awaitInputWithConversion<T>(message: String?, conversion: (_ input: String) -> T?) -> T {
        let input = awaitInputWithValidation(message: message) { (input) in
            return conversion(input) != nil
        }
        
        return conversion(input)!
    }
    
    /**
        Awaits the input of an Int
        - Parameter message: message to be printed before accepting input (e.g. "Name: ")
    */
    public static func awaitInt(message: String?) -> Int {
        return awaitInputWithConversion(message: message) { Int($0) }
    }
    
    /**
        Awaits yes/no input; "y" and "yes" are accepted as yes and "n" and "no" are accepted as no (case insensitive)
        - Parameter message: message to be printed before accepting input (e.g. "Name: ")
    */
    public static func awaitYesNoInput(message: String = "Confirm?") -> Bool {
        return awaitInputWithConversion(message: "\(message) [y/N]: ") {(input) in
            if input.lowercased() == "y" || input.lowercased() == "yes" {
                return true
            } else if input.lowercased() == "n" || input.lowercased() == "no" {
                return false
            }
            
            return nil
        }
    }
    
}
