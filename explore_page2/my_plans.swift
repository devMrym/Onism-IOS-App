import SwiftUI

struct Plan: Identifiable {
    let id = UUID()
    let country: String
    let dateRange: String
    let imageName: String
}

struct my_plans: View {
    let activePlan = Plan(country: "Dubai, UAE", dateRange: "1 Nov → 20 Nov", imageName: "UAE")
    let otherPlans = [
        Plan(country: "Florence, Italy", dateRange: "3 Dec → 20 Dec", imageName: "Florence, Italy"),
        Plan(country: "Cairo, Egypt", dateRange: "1 Jan → 5 Jan", imageName: "Cairo, Egypt"),
        Plan(country: "Bali, Indonesia", dateRange: "20 Jan → 1 Feb", imageName: "Bali, Indonesia")
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                // Fixed header (My Plans)
                ZStack(alignment: .leading) {
                    HStack {
                        Text("My Plans")
                            .font(.largeTitle)
                            .bold()
                            .padding(.leading, 16)
                        
                        Spacer()
                        
                        NavigationLink(destination: FavoriteView()) {
                            Image(systemName: "heart.circle")
                                .padding(.trailing, 16)
                                .font(.largeTitle)
                                .foregroundColor(Color(red: 88/255, green: 86/255, blue: 214/255))
                        }
                    }
                    .padding(.top, 20) // You can adjust the top padding as needed
                }
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("Active Plan")
                        .font(.title2).bold()
                        .padding(.leading, 16)
                    
                    // Active Plan
                    NavigationLink(destination: TripPlanView()) {
                        PlanCard(plan: activePlan)
                            .padding(.horizontal)
                    }
                    
                    Divider()
                    
                    Text("Other Plans")
                        .font(.title2).bold()
                        .padding(.leading, 16)
                    
                    // Scrollable Other Plans
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(otherPlans) { plan in
                            PlanCard(plan: plan)
                                .padding(.horizontal)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct PlanCard: View {
    let plan: Plan

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Background image
            Image(plan.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    // Gradient overlay
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.6), Color.clear]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                )
            
            HStack {
                // Text overlay
                ZStack() {
                    Text(plan.country)
                        .font(.headline)
                        .padding([.bottom, .leading], 17)
                        .bold()
                        .frame(width: 370, height: 50, alignment: .leading)
                        .background(Color.white.opacity(0.7))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .position(x: 169, y: 80)
                    
                    Text(plan.dateRange)
                         .font(.subheadline)
                         .padding([.top, .leading], 20)
                        .bold()
                        .frame(width: 370, height: 50, alignment: .leading)
                        .foregroundColor(.black)
                        .position(x: 167, y: 83)
                }
                .padding()
                Spacer()
                
                Image(systemName: "arrow.right.circle.fill")
                    .padding()
                    .font(.largeTitle)
                    .foregroundColor(Color(red: 88/255, green: 86/255, blue: 214/255))
                    .position(x: 150, y: 95)
            }
        }
        .frame(height: 120)
    }
}

struct my_plans_Previews: PreviewProvider {
    static var previews: some View {
        my_plans()
    }
}
