//
//  LocationsViewModel.swift
//  Xam Map
//
//  Created by Samuel Ofori on 1/21/22.
//

import SwiftUI
import MapKit

class LocationsViewModel : ObservableObject {
    
    // All loaded locations
    @Published var locations: [Location]
    
    // Current map location
    @Published var mapLocation: Location {
        didSet{
            updateMapRegion(location: mapLocation)
        }
    }
    
    
    @Published var showLocationList : Bool = false
    
    @Published var mapRegion : MKCoordinateRegion = MKCoordinateRegion()
    
    //Show location detail via sheet
    @Published var sheetLocation : Location? = nil
    
    let mapSpan = MKCoordinateSpan(
        latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    init(){
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(location: mapLocation)
    }
    
    private func updateMapRegion(location: Location){
        withAnimation (.easeInOut){
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan)
        }
}
    
    func toggleLocationList(){
        withAnimation(.easeInOut){
            showLocationList.toggle()
        }
    }
    
    func showNextLocation(location: Location){
        withAnimation(.easeInOut){
            mapLocation=location
            showLocationList = false
        }
    }
    
    func nextButtonPressed(){
        // Get the current index
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation})
        else {
            print("Should never happen")
            return
        }
        
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else{
            guard let firstLocation = locations.first else { return }
            showNextLocation(location: firstLocation)
            return
        }
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
}
