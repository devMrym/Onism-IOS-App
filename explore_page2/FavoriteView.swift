import SwiftUI

struct FavoriteView: View {
    @EnvironmentObject var favoriteCountries: FavoriteCountries  // Access shared model
    
    var body: some View {
        ZStack{
            NavigationView(){
                VStack {
                    Text("Favorites")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    
                    // Show favorites
                    if favoriteCountries.favorites.isEmpty {
                    
                        Text("No favorites yet.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    } else {
                        List(favoriteCountries.favorites, id: \.self) { country in
                            LocationCard(imageName: country, title: country)
                        }
                        
                    }
                    
                    Spacer()
                    
                    
                }
                .navigationBarTitleDisplayMode(.inline)
                
            }
                
            }
        }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
            .environmentObject(FavoriteCountries())
    }
}


// Reusable location card component
struct LocationCard: View {
    var imageName: String
    var title: String

    
    var body: some View {
        ZStack {
            
          
            
            ZStack(alignment: . bottom){
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 380,height: 180,alignment: .top)
                    .clipped().cornerRadius(20)
                
                VStack {
                    //    Spacer()
                    ZStack(){
                        Text(title)
                            .padding()
                            .font(.title2)
                            .bold()
                            .frame(width: 380, height: 70, alignment: .leading)
                            .background(Color.white.opacity(0.8))
                            .foregroundColor(.black)
                            .cornerRadius(20)
                        
                     /*   Image(systemName: "arrow.right.circle.fill").resizable().frame(width: 50, height: 50).foregroundColor((Color(red: 88/255, green: 86/255, blue: 214/255))).font(.system(size: 50, weight: .bold))
                      */
                        
                    }
                    .padding(.horizontal)
                    //  .background(Color.black.opacity(0.5))
                }
            }
        }
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
