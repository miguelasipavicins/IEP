//
//  Event.swift
//  IEP
//
//  Created by Miguel Asipavicins on 09/04/16.
//  Copyright © 2016 Miguel Asipavicins. All rights reserved.
//

import Foundation
import UIKit
    
    class Event {
        
        private var _name: String!
        private var _place: String!
        private var _date: String!
        private var _time: String!
        private var _description: String!
        private var _imagePath: String?
        private var _formPath: String!
        
        var name: String{
            return _name
        }
        
        var place: String{
            return _place
        }
        
        var date: String{
            return _date
        }
        
        var time: String{
            return _time
        }
        
        var description: String{
            return _description
        }
        
        var imagePath: String?{
            return _imagePath
        }
        
        var formPath: String{
            return _formPath
        }
        
        init(name: String, place: String, date: String, time: String, description: String){
            
            _name = name
            _place = place
            _date = date
            _time = time
            _description = description
            //_imagePath = imagePath
                        //        _formPath = formPatch
        }
    
}