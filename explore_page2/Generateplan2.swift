import SwiftUI

struct Generateplan2: View { //0
    @State private var budget = ""
    @State private var numOfActivity = ""
    @State private var isHalalSelected = false
    @State private var isFamilyFriendlySelected = false
    @State private var showAlert: Bool = false
    
    var body: some View { //1
        NavigationView {
            VStack { //2
                VStack(spacing: 20) {
                    Text("Generate Plan").font(.title).bold()
                    
                    ProgressView(value: 4, total: 6)
                        .tint(Color(red: 88/255, green: 86/255, blue: 214/255))
                        .scaleEffect(x: 1, y: 2, anchor: .center)
                        .padding()
                    Text("2/3")
                        .padding(.leading, 320)
                        .padding(.top, -25)
                }
                
                VStack(alignment: .leading) { //4
                    Text("How Much Are You Willing To Spend?").font(.headline).padding()
                    TextField("$ Enter your budget", text: $budget)
                        .keyboardType(.numberPad)
                        .padding()
                        .textFieldStyle(.roundedBorder)
                    
                    Text("How Many Activities Per Day?").font(.headline).padding()
                    TextField("Activities per day", text: $numOfActivity)
                        .keyboardType(.numberPad)
                        .onChange(of: numOfActivity) { newValue in
                            if let intValue = Int(newValue), intValue > 5 {
                                showAlert = true
                                numOfActivity = String(numOfActivity.prefix(newValue.count - 1))
                            } else {
                                showAlert = false
                            }
                        }
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    if showAlert {
                        Text("Please enter a value less than or equal to 5")
                            .foregroundColor(.red)
                            .font(.footnote)
                            .padding(.top, 5)
                    }
                    
                    Text("Choose Your Preferences").font(.headline).padding()
                    HStack {
                        VStack {
                            Button(action: { isHalalSelected.toggle() }) {
                                VStack {
                                    Image(systemName: "fork.knife")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(isHalalSelected ? .darkPurple : .black)
                                    Text("Halal Food Only")
                                        .font(.system(size: 12))
                                        .foregroundColor(isHalalSelected ? .darkPurple : .black)
                                }.padding()
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        
                        VStack {
                            Button(action: { isFamilyFriendlySelected.toggle() }) {
                                VStack {
                                    Image(systemName: "person.3.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(isFamilyFriendlySelected ? .darkPurple : .black)
                                    Text("Family Friendly")
                                        .font(.system(size: 12))
                                        .foregroundColor(isFamilyFriendlySelected ? .darkPurple : .black)
                                }.padding()
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    
                    NavigationLink(destination: CustomTripPlanView()) {
                        Text("Next")
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 220)
                            .background(Color(red: 88/255, green: 86/255, blue: 214/255))
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 100)
                    .padding(.horizontal, 100)
                }
                .padding(.leading)
            }
           
        }
    }
}

#Preview {
    Generateplan2()
}
