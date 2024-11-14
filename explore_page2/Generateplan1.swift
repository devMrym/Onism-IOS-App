

import SwiftUI
struct City: Identifiable, Hashable {
    let id = UUID()
    let name: String
}

struct contery: Identifiable,Hashable {
    let id = UUID()
    let label: String
    let tag: String
    let cities: [City]
}

let conteries = [
    contery(label: "Indonesia",tag: "tag1" , cities:[City(name: "Jakarta"), City(name: "Bali")]),
    contery(label: "Italy",tag: "tag2" ,cities: [City(name: "Rome"), City(name: "Venice")]),
    contery(label: "Saudi Arabia",tag: "tag3",cities: [City(name: "Jeddah"), City(name: "Riyadh")]),
    contery(label: "UAE",tag: "tag4",cities: [City(name: "Dubai"), City(name: "Abu Dhabi")])
    ]

struct Generateplan1: View {//0
    @State private var selectedCity: City?
    @State private var selectedContery: contery = conteries[2]//Default selection
    @State private var startDate = Date()
    @State private var endDate = Date()
    
    var body: some View {//1
        NavigationStack{
            VStack {//2
                VStack( spacing: 20) {//3
                    Text("Generate Plan").font(.title).bold()
                    
                    ProgressView(value: 2,total: 6)
                        .tint(Color(red:88/255,green: 86/255,blue:214/255))
                        .scaleEffect(x: 1, y: 2, anchor: .center)
                        .padding()
                    Text("1/3")
                        .padding(.leading,320)
                        .padding(.top,-25)
                    
                    
                }//3F
                
                
                VStack {//4
                    Text("Where To?").font(.headline).padding(.leading,-185)
                    NavigationStack{
                        Form{
                            Picker(
                                selection:$selectedContery,
                                label:HStack{
                                    Text("Select Countery")
                                }
                                
                                ,
                                content: {
                                    ForEach(conteries) { contery in
                                        Text(contery.label).tag(contery)
                                        
                                    }
                                }
                            )
                            .pickerStyle(.menu)
                            
                            Picker("Select City", selection: $selectedCity) {
                                ForEach(selectedContery.cities, id: \.self) { city in
                                    Text(city.name).tag(city as City)
                                }
                            }
                            .pickerStyle(.menu)
                            
                            
                            
                        }.padding(.top,-60)
                            .padding(.horizontal,-40)
                            .scrollContentBackground(.hidden)
                            .scrollDisabled(true)
                        
                        
                        
                        
                        VStack{
                            
                            
                            
                            ZStack{
                                Text("Select Start Date").font(.headline).padding(.top,-300).position(x: 67,y:210)
                                
                                DatePicker("Start Date", selection: $startDate,in: Date()...,displayedComponents: [.date]).position(x:188,y:-40)
                            }
                            DatePicker("End Date", selection: $endDate,in: startDate...,displayedComponents: [.date]).position(x:188,y:-100)
                        }
                    }.padding()
                    //4F
                    
                    NavigationLink(destination: Generateplan2()){
                        Text("Next")
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 220)
                            .background(Color(red:88/255,green: 86/255,blue:214/255))
                            .cornerRadius(10)
                    }
                    .padding(.bottom,100).padding(.horizontal,100)
                }
            }
        }//1
    }//0
}
#Preview {
    Generateplan1()
}
