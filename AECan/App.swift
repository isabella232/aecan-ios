//
//  App.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 15/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

class App {
    
    private static var devApiBaseUrl = "https://dev.aecan.vortexsoftware.com.ar/api/v1/"
    private static var stagingApiBaseUrl = "http://aecan.inmindsoftware.com/api/v1/"
    
    static var apiBaseUrl: String {
        switch Environment.currentServerEnv {
        case .development:
            return devApiBaseUrl
        case .staging:
            return stagingApiBaseUrl
        }
    }
    
    static var defaultErrorMessage = "Ocurrió un error"
}
