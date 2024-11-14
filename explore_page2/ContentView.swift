import SwiftUI

struct ContentView: View {
    @EnvironmentObject var favoriteCountries: FavoriteCountries

    @State private var isFavorite = false
    
    // List of countries to show in the explore view
    let countries = [
        ("Riyadh, KSA", "Riyadh, KSA", "$$$"),
        ("Cairo, Egypt", "Cairo, Egypt", "$$"),
        ("Bali, Indonesia", "Bali, Indonesia", "$$"),
        ("Florence, Italy", "Florence, Italy", "$$")
    ]
    
    var body: some View {
        NavigationStack {  // Apply NavigationView at the top level
            TabView {
                
                // Explore Tab
                VStack {
                    Text("Explore")
                        .font(.largeTitle)
                        .bold()
                        .padding(.trailing, 255)
                    Divider()
                    Text("Customize your plan").font(.system(size: 18))
                        .frame(width: 370, alignment: .leading)
                        .foregroundColor(.black)
                    
                    NavigationLink(destination: Generateplan1()) {
                        ZStack {
                            Text("")
                                .font(.title)
                                .frame(width: UIScreen.main.bounds.width * 0.92, height: UIScreen.main.bounds.width * 0.6)
                                .background(Color(red: 88/255, green: 86/255, blue: 214/255))
                                .foregroundColor(.white)
                                .cornerRadius(12)
                            VStack(spacing: 10) {
                                Image(systemName: "plus.square").resizable().frame(width: 100, height: 100).foregroundColor(.white).font(.system(size: 50, weight: .bold)).padding(.all , 10)
                                Text("Generate Your Own Plan").foregroundColor(.white).font(.system(size: 20, weight: .bold))
                                Text("Tell us where and when and we will handle the rest!").foregroundColor(.white).font(.system(size: 14))
                            }
                        }
                    }
                    Divider()
                        .padding(.bottom)
                    HStack {
                        Text("Explore Our Plans").font(.system(size: 18)).foregroundColor(.black)
                            .frame(width: 300, alignment: .leading).foregroundColor(.gray).padding(.bottom)
                        NavigationLink(destination: Explore_all()) {
                            Text("See All").font(.system(size: 18))
                                .frame(alignment: .leading).foregroundColor(.gray).padding(.bottom)
                        }
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            
                            ForEach(countries, id: \.0) { country in
                                ZStack {
                                   
                                    if country.0 == "Florence, Italy" {
                                        NavigationLink(destination: Plan_example()) {
                                            ZStack {
                                                Image(country.1)
                                                    .resizable()
                                                    .frame(width: 250, height: 250)
                                                    .cornerRadius(20)
                                                
                                                Text(country.0)
                                                    .padding()
                                                    .bold()
                                                    .frame(width: 250, height: 70, alignment: .leading)
                                                    .background(Color.white.opacity(0.8))
                                                    .foregroundColor(.black)
                                                    .cornerRadius(20)
                                                    .position(x: 125, y: 223)
                                                
                                                Image(systemName: "arrow.right.circle.fill")
                                                    .resizable()
                                                    .frame(width: 50, height: 50)
                                                    .foregroundColor(Color(red: 88/255, green: 86/255, blue: 214/255))
                                                    .font(.system(size: 50, weight: .bold))
                                                    .position(x: 210, y: 223)
                                                
                                                // Favorite Button
                                                Button(action: {
                                                    favoriteCountries.toggleFavorite(for: country.0)
                                                }) {
                                                    Image(systemName: favoriteCountries.favorites.contains(country.0) ? "heart.fill" : "heart")
                                                        .resizable()
                                                        .frame(width: 28, height: 28)
                                                        .offset(x: -9.7, y: 1)
                                                        .foregroundColor(Color(red: 88/255, green: 86/255, blue: 214/255))
                                                        .padding()
                                                }
                                                .background(Color.white.opacity(0.75))
                                                .clipShape(Circle().size(width: 40, height: 60))
                                                .position(x: 224, y: 35)
                                            }
                                        }
                                    } else {
                                        // For other countries, don't use NavigationLink or link to a different view
                                        ZStack {
                                            Image(country.1)
                                                .resizable()
                                                .frame(width: 250, height: 250)
                                                .cornerRadius(20)
                                            
                                            Text(country.0)
                                                .padding()
                                                .bold()
                                                .frame(width: 250, height: 70, alignment: .leading)
                                                .background(Color.white.opacity(0.8))
                                                .foregroundColor(.black)
                                                .cornerRadius(20)
                                                .position(x: 125, y: 223)
                                            
                                            Image(systemName: "arrow.right.circle.fill")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .foregroundColor(Color(red: 88/255, green: 86/255, blue: 214/255))
                                                .font(.system(size: 50, weight: .bold))
                                                .position(x: 210, y: 223)
                                            
                                            // Favorite Button
                                            Button(action: {
                                                favoriteCountries.toggleFavorite(for: country.0)
                                            }) {
                                                Image(systemName: favoriteCountries.favorites.contains(country.0) ? "heart.fill" : "heart")
                                                    .resizable()
                                                    .frame(width: 28, height: 28)
                                                    .offset(x: -9.7, y: 1)
                                                    .foregroundColor(Color(red: 88/255, green: 86/255, blue: 214/255))
                                                    .padding()
                                            }
                                            .background(Color.white.opacity(0.75))
                                            .clipShape(Circle().size(width: 40, height: 60))
                                            .position(x: 224, y: 35)
                                        }
                                    }
                                }
                            }
                        }
                        .padding()
                    }

                    Divider()
                }
                .tabItem {
                    Image(systemName: "globe")
                    Text("Explore")
                }
                
                // Active Plan Tab
                TripPlanView()
                    .tabItem {
                        Image(systemName: "map")
                        Text("Active Plan")
                    }

                // My Plans Tab
                my_plans()
                    .tabItem {
                        Image(systemName: "note.text")
                        Text("My Plans")
                    }
            }
        }
      
        .accentColor(Color(red: 88/255, green: 86/255, blue: 214/255))
    }
}

struct AnotherView: View {
    var body: some View {
        Text("This is another page.")
            .font(.largeTitle)
            .navigationBarTitle("Another Page", displayMode: .inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(FavoriteCountries())
    }
}
