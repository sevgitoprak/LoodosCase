//
//  StringExtensions.swift
//  Case
//
//  Created by Sevgi Toprak on 13.02.2024.
//

import Foundation

extension String {
    var trimNumericPart: String {
        let numericCharacters = CharacterSet.decimalDigits
        let numericPart = self.filter { numericCharacters.contains(Unicode.Scalar(String($0))!) }
        return String(numericPart)
    }

    var formattedTimeFromMinutes: String {
        if let totalMinutes = Int(self) {
            let hours = totalMinutes / 60
            let minutes = totalMinutes % 60
            return String(format: "%dh %dm", hours, minutes)
        } else {
            return ""
        }
    }
}


