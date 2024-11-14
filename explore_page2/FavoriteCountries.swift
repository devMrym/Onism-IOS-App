import SwiftUI

class FavoriteCountries: ObservableObject {
    @Published var favorites: [String] = []
    
    func toggleFavorite(for country: String) {
        if favorites.contains(country) {
            favorites.removeAll { $0 == country }
        } else {
            favorites.append(country)
        }
    }
}
