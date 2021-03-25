//
//  Question.swift
//  Icebreaker
//
//  Created by kuntong xu on 2/28/21.
//

import Foundation
class Question{
    var id: String
    var text: String
    
    init?(id:String, data:[String : Any]) {
        guard let text = data["text"] as?String
        else {
            return nil
            
        }
        self.id = id
        self.text = text
    }
    
}
