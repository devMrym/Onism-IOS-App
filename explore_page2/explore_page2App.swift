//
//  explore_page2App.swift
//  explore_page2
//
//  Created by Maryam Alonazi on 04/05/1446 AH.
//

import SwiftUI

@main
struct explore_page2App: App {
    @StateObject private var favoriteCountries = FavoriteCountries()  // Create shared object
       
    var body: some Scene {
           WindowGroup {
               SplashScreenView()
                   .environmentObject(FavoriteCountries())
           }
       }
   }
