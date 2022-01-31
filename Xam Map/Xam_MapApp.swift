//
//  Xam_MapApp.swift
//  Xam Map
//
//  Created by Samuel Ofori on 1/20/22.
//

import SwiftUI

@main
struct Xam_MapApp: App {
    @StateObject private var vm = LocationsViewModel()

    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
