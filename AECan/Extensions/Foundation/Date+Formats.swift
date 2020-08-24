//
//  Date+Formats.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 04/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation

extension Date {
    
    /// dd/MM/yyyy - HH:mm
    var longFormat1: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy - HH:mm"
        return formatter.string(from: self)
    }
    
    /// dd/MM/yyyy
    var shortFormat1: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: self)
    }
    
    /// yyyy-MM-dd
    var dbFormat1: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
}
