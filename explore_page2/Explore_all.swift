//
//  ContentView.swift
//  Application Edit
//
//  Created by Noura A. Alameel on 03/05/1446 AH.
//

import SwiftUI
struct Explore_all: View {
    @EnvironmentObject var favoriteCountries: FavoriteCountries
    
    @State private var selectedCategory = "All" // Default category to show all
    let categories = ["All", "Saudi", "Egypt", "Indonesia", "Italy"]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                // Title
                Text("Explore Our Plans")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                // Category Selection Tabs
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(categories, id: \.self) { category in
                            Text(category)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(selectedCategory == category ? Color.gray.opacity(0.2) : Color.clear)
                                .cornerRadius(15)
                                .onTapGesture {
                                    selectedCategory = category
                                }
                        }
                    }
                    .padding(.horizontal)
                }
                
                // List of Destinations
                ScrollView {
                    VStack(spacing: 16) {
                        let destinations = getDestinations(for: selectedCategory)
                        if destinations.isEmpty {
                            Text("No destinations available for \(selectedCategory)")
                                .foregroundColor(.gray)
                                .padding()
                        } else {
                            ForEach(destinations, id: \.self) { destination in
                                DestinationCard(destination: destination)
                                    .environmentObject(favoriteCountries) // Pass down environment object
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    // Function to filter destinations based on the selected category
    func getDestinations(for category: String) -> [Destination] {
        if category == "All" {
            return sampleDestinations // Show all destinations when "All" is selected
        }
        return sampleDestinations.filter { $0.category == category }
    }
}

// Model for Destination
struct Destination: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let category: String
    let priceRange: String
    let imageName: String
    let isAvailable: Bool
}

// Sample destinations
let sampleDestinations = [
    Destination(name: "Riyadh, KSA", category: "Saudi", priceRange: "$$$", imageName: "Riyadh, KSA", isAvailable: true),
    Destination(name: "Cairo, Egypt", category: "Egypt", priceRange: "$$", imageName: "Cairo, Egypt", isAvailable: true),
    Destination(name: "Bali, Indonesia", category: "Indonesia", priceRange: "$$", imageName: "Bali, Indonesia", isAvailable: true),
    Destination(name: "Florence, Italy", category: "Italy", priceRange: "$$", imageName: "Florence, Italy", isAvailable: true)
]

// View for a single destination card
struct DestinationCard: View {
    let destination: Destination
    @EnvironmentObject var favoriteCountries: FavoriteCountries
    
    var body: some View {
        ZStack {
            Image(destination.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 120,alignment: .topLeading)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
                .grayscale(destination.isAvailable ? 0 : 1)
                .opacity(destination.isAvailable ? 1 : 0.4)
            
            HStack {
                VStack(alignment: .leading) {
                    ZStack {
                        HStack {
                            Text(destination.name)
                            Text(destination.priceRange)
                                .padding(.leading, 1)
                        }
                        .padding()
                        .bold()
                        .frame(width: 340, height: 50, alignment: .leading)
                        .background(Color.white.opacity(0.75))
                        .foregroundColor(.black)
                        .cornerRadius(20)
                        .position(x: 154, y: 83)
                    }
                }
                .padding()
                
                Spacer()
                
                VStack {
                    Button(action: {
                        favoriteCountries.toggleFavorite(for: destination.name)
                    }) {
                        Image(systemName: favoriteCountries.favorites.contains(destination.name) ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 28, height: 28) .position(x:4.5, y:15)
                            .foregroundColor(favoriteCountries.favorites.contains(destination.name) ? Color(red: 88/255, green: 86/255, blue: 214/255) : .black)
                            .padding()
                    }
                    .background(Color.white.opacity(0.75))
                    .clipShape(Circle().size(width: 40, height: 60))
                    .position(x:197,y:30)
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "arrow.right.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color(red: 88/255, green: 86/255, blue: 214/255))
                            .position(x:140, y:32)
                    }
                }
            }
        }
        .frame(height: 120)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(20)
        .padding(.horizontal)
    }
}

// Preview
struct plan_example_Previews: PreviewProvider {
    static var previews: some View {
        Explore_all()
            .environmentObject(FavoriteCountries())
    }
}
