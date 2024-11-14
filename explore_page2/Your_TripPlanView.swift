import SwiftUI
import MapKit

struct TripPlanView: View {
    // Define the custom purple color
    static let darkPurple = Color(red: 88 / 255, green: 86 / 255, blue: 214 / 255)

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 25.276987, longitude: 55.296249),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05) // Adjust span for zoom level
    )
    
    @State private var selectedDay: String?
    @State private var isFullScreenMapPresented = false

    let day1Activities = [
        Location(name: "Joe's Cafe", costRange: "$20 - 30", coordinate: CLLocationCoordinate2D(latitude: 25.1972, longitude: 55.2797), timeRequired: "1 Hour", ratings: "4.5 ★"),
        Location(name: "Dubai Aquarium", costRange: "$90 - 100", coordinate: CLLocationCoordinate2D(latitude: 25.1985, longitude: 55.2796), timeRequired: "2 Hours", ratings: "4.7 ★"),
        Location(name: "Dubai Mall", costRange: "$70 - 80", coordinate: CLLocationCoordinate2D(latitude: 25.1975, longitude: 55.2744), timeRequired: "3 Hours", ratings: "4.6 ★"),
     
    ]

    let day2Activities = [
        Location(name: "Museum of the Future", costRange: "$40 - 50", coordinate: CLLocationCoordinate2D(latitude: 25.2285, longitude: 55.2843), timeRequired: "1.5 Hours", ratings: "4.9 ★"),
        Location(name: "The Green Planet", costRange: "$60 - 70", coordinate: CLLocationCoordinate2D(latitude: 25.2086, longitude: 55.2719), timeRequired: "1 Hour", ratings: "4.6 ★"),
        Location(name: "Jumeirah Beach", costRange: "$0", coordinate: CLLocationCoordinate2D(latitude: 25.1516, longitude: 55.2083), timeRequired: "3 Hours", ratings: "4.4 ★")
    ]

    let day3Activities = [
        Location(name: "Dubai Miracle Garden", costRange: "$50 - 60", coordinate: CLLocationCoordinate2D(latitude: 25.0562, longitude: 55.2477), timeRequired: "2 Hours", ratings: "4.7 ★"),
        Location(name: "Global Village", costRange: "$15 - 25", coordinate: CLLocationCoordinate2D(latitude: 25.0666, longitude: 55.3064), timeRequired: "4 Hours", ratings: "4.8 ★"),
       
        Location(name: "Sky Views Dubai", costRange: "$75 - 85", coordinate: CLLocationCoordinate2D(latitude: 25.1952, longitude: 55.2729), timeRequired: "2 Hours", ratings: "4.5 ★")
        
    ]

    // Dynamically selecting the locations based on the selected day
    var locations: [Location] {
        switch selectedDay {
        case "Day 1":
            return day1Activities
        case "Day 2":
            return day2Activities
        case "Day 3":
            return day3Activities
        
        default:
            return []
        }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ZStack(alignment: .center) {
                    Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, annotationItems: locations) { location in
                        MapAnnotation(coordinate: location.coordinate) {
                            Button(action: {
                                isFullScreenMapPresented.toggle()
                            }) {
                                VStack {
                                    Image(systemName: "mappin.circle.fill")
                                        .foregroundColor(.red)
                                        .font(.title)
                                    Text(location.name)
                                        .font(.caption)
                                        .padding(5)
                                        .background(Color.white.opacity(0.8))
                                        .cornerRadius(5)
                                }
                            }
                        }
                    }
                    .frame(height: 300)
                    .clipShape(RoundedCornersShape(radius: 15, corners: [.bottomLeft, .bottomRight])) // Custom corner radius function
                    .onTapGesture {
                        isFullScreenMapPresented.toggle()
                    }

                    Text("Trip to UAE, Dubai")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .padding(.top, 60)
                }

                // Day selection and activities list
                VStack {
                    HStack {
                        Text(selectedDay ?? "Choose a Day")
                            .font(.headline)
                            .foregroundColor(.white)
                        Spacer()
                        Menu {
                            Button("Day 1") { selectedDay = "Day 1" }
                            Button("Day 2") { selectedDay = "Day 2" }
                            Button("Day 3") { selectedDay = "Day 3" }
                        } label: {
                            Image(systemName: "chevron.down")
                                .foregroundColor(.white) // White arrow
                                .padding() // No background circle
                        }
                    }
                    .padding()
                    .background(TripPlanView.darkPurple) // Changed to purple
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top, 20)
                }
                .padding(.bottom, 10)

                // Only display activities if a day has been selected
                if !locations.isEmpty {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(locations) { activity in
                            ItineraryItemView(name: activity.name, costRange: activity.costRange, timeRequired: activity.timeRequired, ratings: activity.ratings)
                        }
                    }
                    .padding(.horizontal)
                }

                Spacer()
            }
            .background(Color.white)
            .edgesIgnoringSafeArea(.top)
            .fullScreenCover(isPresented: $isFullScreenMapPresented) {
                ExpandedMapView(isMapExpanded: $isFullScreenMapPresented)
            }
        }
    }
}

// Expanded full-screen map view
struct ExpandedMapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 25.276987, longitude: 55.296249),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05) // Adjust span for zoom level
    )
    @Binding var isMapExpanded: Bool

    var body: some View {
        ZStack(alignment: .topTrailing) {
            
         
            
            Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true)
                .edgesIgnoringSafeArea(.all)
            
            Button(action: {
                isMapExpanded.toggle()
            }) {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
            }
        }
    }
}

// Location Model with Extra Fields
struct Location: Identifiable {
    var id = UUID()
    var name: String
    var costRange: String
    var coordinate: CLLocationCoordinate2D
    var timeRequired: String
    var ratings: String
}

struct ItineraryItemView: View {
    let name: String
    let costRange: String
    let timeRequired: String
    let ratings: String

    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Circle()
                .fill(TripPlanView.darkPurple) // Changed bullet color to purple
                .frame(width: 14, height: 14)
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(name)
                        .font(.body)
                        .foregroundColor(.white)
                    Spacer()
                    Text(costRange)
                        .font(.body)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(TripPlanView.darkPurple) // Updated to purple
                .cornerRadius(10)
                
                HStack {
                    Text("Time: \(timeRequired)")
                    Spacer()
                    Text("Ratings: \(ratings)")
                }
                .font(.subheadline)
                .foregroundColor(.gray)
            }
        }
    }
}

// Custom Shape for Rounded Map
struct RoundedCornersShape: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

// PreviewProvider
struct TripPlanView_Previews: PreviewProvider {
    static var previews: some View {
        TripPlanView()
    }
}
