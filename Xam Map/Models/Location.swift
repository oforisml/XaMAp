//
//  Location.swift
//  Xam Map
//
//  Created by Samuel Ofori on 1/20/22.
//

import Foundation
import CoreLocation
import MapKit
struct Location: Identifiable, Equatable{
    
    
    let name : String
    let cityName : String
    let coordinates : CLLocationCoordinate2D
    let description : String
    let imageNames : [String]
    let link : String
    
    var id: String{
        name + cityName
    }
    
    static func == (lhs: Location, rhs: Location)-> Bool{
        lhs.id == rhs.id && lhs.cityName == rhs.cityName
    }
}
