//
//  LocationsView.swift
//  Xam Map
//
//  Created by Samuel Ofori on 1/21/22.
//

import SwiftUI
import MapKit


struct LocationsView: View {
    @EnvironmentObject private var vm: LocationsViewModel
    let maxWidthForIpad : CGFloat = 700
    var body: some View {
        ZStack{
                mapLayer
                .ignoresSafeArea()
            
            VStack(spacing: 0){
                header
                 .padding()
                 .frame(maxWidth: maxWidthForIpad)
                 Spacer()
                
                locationPreview
                
            }
        }
        .sheet(item: $vm.sheetLocation, onDismiss: nil){
            LocationDetailView(location:$0)
        } 
            

    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .preferredColorScheme(.dark)
            .environmentObject(LocationsViewModel())
.previewInterfaceOrientation(.portrait)
    }
}



extension LocationsView {
    private var header : some View{
        VStack {
            Button(action: vm.toggleLocationList){
                Text( vm.mapLocation.name + ", " + vm.mapLocation.cityName )
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .animation(.none, value: vm.mapLocation)
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading){
                    Image(systemName: "arrow.down")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding()
                        .rotationEffect(Angle(degrees: vm.showLocationList ? 180 : 0))
                }
            }
            
            if vm.showLocationList{
                LocationsListView()
            }
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 15)
    }
    
    private var mapLayer : some View {
        Map(coordinateRegion: $vm.mapRegion,
            annotationItems: vm.locations,
            annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates){
            LocationMapAnnotationView()
                    .scaleEffect(vm.mapLocation==location ? 1: 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        vm.showNextLocation(location: location)
                    }
            }
                          
   })
    }
    
    private var locationPreview : some View {
        ZStack{
            ForEach(vm.locations){ location in
                if(vm.mapLocation == location){
                    LocationPreviewView(location: location)
                        .shadow(color: Color.black.opacity(0.2), radius: 20)
                        .padding()
                        .frame(maxWidth: maxWidthForIpad)
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
            }
        }
    }
        
}
