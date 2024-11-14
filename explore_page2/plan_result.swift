import SwiftUI

class TripPlannerViewModel: ObservableObject {
    @Published var tripList: [TripDay] = []
    @Published var errorMessage: String?

    func GeneratePlan(budget: String, numOfActivity: Int, isHalalSelected: Bool, isFamilyFriendlySelected: Bool, selectedCity: String, startDate: Date, endDate: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let startDateStr = dateFormatter.string(from: startDate)
        let endDateStr = dateFormatter.string(from: endDate)
        
        // Prepare prompt options
        let halalOption = isHalalSelected ? "halal-friendly" : ""
        let familyOption = isFamilyFriendlySelected ? "family-friendly" : ""
        
        // API call simulated with fallback data for testing
        let responseText = """
        Day 1, Joes Cafe, Dubai Museum,  2 hours, 4/5
        Day 1, Dubai Aquarium, Desert Safari,  2.5 hours, 4.5/5
        Day 1, Dubai Mall, City Park,  2 hours, 4/5
        Day 2, Museum of the Future, Shopping & Dining,  2 hours, 4.5/5
        Day 2, The Green Planet, Shopping & Dining,  3 hours, 4.5/5
        Day 2, Jumeirah Beach, Shopping & Dining,  2 hours, 4.5/5
        Day 3,Dubai Miracle Garden, Shopping & Dining,  2 hours, 4.5/5
        Day 3, Global Village, Shopping & Dining,  3 hours, 4.5/5
        Day 3, Sky Views Dubai, Shopping & Dining,  2 hours, 4.5/5
        """
        
        parseResponse(responseText, numOfActivity: 3)
    }
    
    private func parseResponse(_ responseText: String, numOfActivity: Int) {
        var tripDays: [TripDay] = []
        let lines = responseText.split(separator: "\n")
        var dayNum = 1
        var activityCount = 0

        for line in lines {
            let parts = line.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces) }
            if parts.count >= 4 {
                let activity = parts[1]
                let location = parts[2]
                let duration = parts[3]
                

                if activityCount == numOfActivity {
                    dayNum += 1
                    activityCount = 0
                }

                let tripDay = TripDay(dayNum: dayNum, activity: activity, location: location, duration: duration)
                tripDays.append(tripDay)
                activityCount += 1
            }
        }

        if tripDays.isEmpty {
            tripDays = [
                TripDay(dayNum: 1, activity: "Visit museum", location: "City Museum", duration: "2 hours"),
                TripDay(dayNum: 2, activity: "City park", location: "Central Park", duration: "3 hours")
            ]
        }

        self.tripList = tripDays
    }
}

struct TripDay: Identifiable {
    let id = UUID()
    let dayNum: Int
    let activity: String
    let location: String
    let duration: String
 
}

struct CustomTripPlanView: View {
    @StateObject private var viewModel = TripPlannerViewModel()
    
    var body: some View {
        VStack {
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage).foregroundColor(.red)
            }

            plan_result(viewModel: viewModel)
                .onAppear {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd.MM.yy"
                    
                    if let startDate = dateFormatter.date(from: "26.08.24"),
                       let endDate = dateFormatter.date(from: "1.09.24") {
                        viewModel.GeneratePlan(
                            budget: "5000",
                            numOfActivity: 2,  // Dynamic number of activities per day
                            isHalalSelected: true,
                            isFamilyFriendlySelected: true,
                            selectedCity: "Riyadh",
                            startDate: startDate,
                            endDate: endDate
                        )
                    } else {
                        viewModel.errorMessage = "Invalid start or end date format."
                    }
                }
        }
    }
}

#Preview {
    CustomTripPlanView()
}
