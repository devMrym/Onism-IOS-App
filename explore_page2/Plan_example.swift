import SwiftUI

// Define a custom dark purple color
extension Color {
    static let darkPurple = Color(red: 88 / 255, green: 86 / 255, blue: 214 / 255)
}

// ContentView with a button to navigate to the next page
struct Plan_example: View {
    @State private var isRestaurantsExpanded = false
    @State private var isActivitiesExpanded = false
    @State private var isScheduleExpanded = false
    
    var body: some View {
        NavigationView {
            ScrollView { // Added ScrollView to make the entire content scrollable
                VStack(alignment: .leading, spacing: 16) {
                    Text("Florence, Italy")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                    
                    // Restaurants Section
                    SectionView(title: "Restaurants", isExpanded: $isRestaurantsExpanded) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("• Osteria Vini e Vecchi Sapori")
                            Text("• Trattoria Mario")
                            Text("• La Giostra")
                            Text("• Enoteca Pitti Gola e Cantina")
                            Text("• Il Santo Bevitore")
                            Text("• Cibrèo Trattoria")
                            Text("• Trattoria Sostanza")
                            Text("• Ristorante Ora d'Aria")
                            Text("• Ristorante La Bottega del Buon Caffè")
                            Text("• Ristorante Buca Lapi")
                            Text("• Trattoria ZaZa")
                            Text("• Ristorante Enoteca Pinchiorri")
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                        .foregroundColor(.white)
                        .font(.body)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    // Activities Section
                    SectionView(title: "Activities", isExpanded: $isActivitiesExpanded) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("• Visit Uffizi Gallery")
                            Text("• Explore Ponte Vecchio")
                            Text("• Take a Cooking Class")
                            Text("• Visit Florence Cathedral")
                            Text("• Explore Boboli Gardens")
                            Text("• Tour Palazzo Vecchio")
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                        .foregroundColor(.white)
                        .font(.body)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    // Schedule Section
                    SectionView(title: "Schedule", isExpanded: $isScheduleExpanded) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("• Day 1: Arrival and Dinner")
                            Text("• Day 2: Museums and Sightseeing")
                            Text("• Day 3: Shopping and Departure")
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                        .foregroundColor(.white)
                        .font(.body)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    Spacer()
              
                    .padding(.top, 20)
                }
                .padding()
            }
            .background(Color.white)
            .navigationTitle("Travel Guide")
        }
    }
}

// Define the NextPageView as the next page
struct NextPageView: View {
    var body: some View {
        Text("Welcome to the Next Page!")
            .font(.title)
            .padding()
            .navigationTitle("Next Page")
    }
}

struct SectionView<Content: View>: View {
    var title: String
    @Binding var isExpanded: Bool
    var content: Content
    
    init(title: String, isExpanded: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self.title = title
        self._isExpanded = isExpanded
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text(title)
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.white)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.darkPurple)
                .cornerRadius(12)
            }
            
            if isExpanded {
                content
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.darkPurple.opacity(0.9))
                    .cornerRadius(12)
                    .padding(.horizontal, 2)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct Plan_example_Previews: PreviewProvider {
    static var previews: some View {
        Plan_example()
    }
}
