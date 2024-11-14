import SwiftUI

struct plan_result: View {
    @ObservedObject var viewModel: TripPlannerViewModel
    @State private var selectedDay: Int? = nil
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Title
                Text("Generate Plan")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top)
                
                // Progress Bar
                ProgressView(value: 6, total: 6)
                    .tint(Color(red: 88/255, green: 86/255, blue: 214/255))
                    .scaleEffect(x: 1, y: 2, anchor: .center)
                    .padding()
                Text("3/3")
                    .padding(.leading, 320) // Leading padding
                    .padding(.top, -25) // Top padding
                
                HStack {
                    VStack {
                        Text("Proposal plan:")
                            .font(.headline)
                    }
                    Spacer()
                    Menu {
                        // Extract unique day numbers from the trip list
                        let uniqueDays = Set(viewModel.tripList.map { $0.dayNum })
                        ForEach(uniqueDays.sorted(), id: \.self) { day in
                            Button(action: { selectedDay = day }) {
                                Text("Day \(day)")
                            }
                        }
                    } label: {
                        HStack {
                            Text(selectedDay != nil ? "Day \(selectedDay!)" : "Select a day")
                            Image(systemName: "chevron.down")
                        }
                    }
                }
            
                .padding([.leading, .trailing])


                // List of Places with Generated Costs
                List {
                    ForEach(viewModel.tripList.filter { selectedDay == nil || $0.dayNum == selectedDay }, id: \.id) { day in
                        PlanRow(place: day.activity, cost: " \(day.duration)")
                    }

                    // Total Cost Section (Placeholder)
                    HStack {
                        Text("Average Day cost")
                        Spacer()
                        Text("$790")
                    }
                    .padding([.top, .bottom])
                    
                    HStack {
                        Text("Overall cost")
                        Spacer()
                        Text("$1580")
                    }
                }
                .listStyle(InsetGroupedListStyle())
                
                // Generate Button
                Button(action: {
                    viewModel.GeneratePlan(
                        budget: "5000",
                        numOfActivity: 4,
                        isHalalSelected: true,
                        isFamilyFriendlySelected: true,
                        selectedCity: "Riyadh",
                        startDate: Date(),
                        endDate: Date().addingTimeInterval(86400 * 7) // Example 7-day period
                    )
                }) {
                    NavigationLink(destination: TripPlanView()) {
                        Text("Activate plan")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 220)
                            .padding()
                            .background(Color(red: 88/255, green: 86/255, blue: 214/255))
                            .cornerRadius(10)
                            .padding([.leading, .trailing, .bottom])
                    }}
            }
        }
    }
}

struct PlanRow: View {
    var place: String
    var cost: String

    var body: some View {
        HStack {
            Text(place)
            Spacer()
            Text(cost)
                .padding(.trailing)
            Image(systemName: "ellipsis")
        }
        .padding()
        .background(Color.blue.opacity(0.2))
        .cornerRadius(10)
    }
}

#Preview {
    CustomTripPlanView()
}
