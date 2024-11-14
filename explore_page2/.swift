import SwiftUI

struct TripPlanView: View {
    @StateObject private var viewModel = TripPlannerViewModel()

    var body: some View {
        VStack {
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage).foregroundColor(.red)
            }

            PlanResultView(viewModel: viewModel)
        }
        .onAppear {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yy"
            
            // Example of setting up initial data for GeneratePlan
            if let startDate = dateFormatter.date(from: "26.08.24"),
               let endDate = dateFormatter.date(from: "1.09.24") {
                viewModel.GeneratePlan(
                    budget: "5000",
                    numOfActivity: 4,
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

#Preview {
    TripPlanView()
}
