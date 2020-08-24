//
//  ComponentAction.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 26/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import ObjectMapper

class StageDetailComponentAction: Mappable {
       
   enum ActionType: String {
        case openInputModal = "open_input_modal"
        case openSelectionModal = "open_selection_modal"
        case openConfirmModal = "open_confirm_modal"
   }
   
    var actionType: ActionType?
    var selectionModal: SelectionModal?
    var inputModal: InputModal?
    var confirmModal: ConfirmModal?
   
   required init?(map: Map) { }
   
   func mapping(map: Map) {
        actionType <- (map["action_type"], EnumTransform<ActionType>())
        selectionModal <- map["selection_modal"]
        inputModal <- map["input_modal"]
        confirmModal <- map["confirm_modal"]
   }
}

class InputModal: Mappable {
    
    enum InputType: String {
        case text = "text"
        case number = "number"
        case date = "date"
    }
    
    var title: String?
    var urlPath: String?
    var buttonText: String?
    var inputType: InputType?
    var prefix: String?
    var suffix: String?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        title <- map["title"]
        urlPath <- map["url_path"]
        buttonText <- map["button_text"]
        inputType <- (map["input_type"], EnumTransform<InputType>())
        prefix <- map["prefix"]
        suffix <- map["suffix"]
    }
}

class SelectionModal: Mappable {
    
    class Option: Mappable {
        var id: Int? // TODO: this should be String (view UC-422)
        var text: String?
        
        required init?(map: Map) { }
        
        func mapping(map: Map) {
            id <- map["id"]
            text <- map["text"]
        }
    }
    
    var value: String?
    var title: String?
    var urlPath: String?
    var buttonText: String?
    var options: [Option] = []
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        value <- map["value"]
        title <- map["title"]
        urlPath <- map["url_path"]
        buttonText <- map["button_text"]
        options <- map["options"]
    }
}

extension SelectionModal.Option: SelectorDialogOption {
    var textForSelector: String? { text }
}

class ConfirmModal: Mappable {
    
    var title: String?
    var urlPath: String?
    var buttonText: String?
    var body: String?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        title <- map["title"]
        urlPath <- map["url_path"]
        buttonText <- map["button_text"]
        body <- map["body"]
    }
}
