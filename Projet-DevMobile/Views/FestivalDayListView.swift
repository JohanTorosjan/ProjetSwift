//
//  FestivalDayListView.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 20/03/2023.
//

import SwiftUI
import AlertToast

struct FestivalDayListView: View {
    @State private var showPopover = false
    @ObservedObject var festival:FestivalModel
    
    @ObservedObject var festivalDayList:FestivalDayListModel
    
    private var dateFormatter=DateFormatter()
    private var festivalDayListIntent:FestivalDayListIntent
    private var isAdmin:Bool
    
    private var festivalIntent:FestivalIntent?
    @State private var newFestivalDayName:String = ""
    @State private var day:Date = Date()
    @State private var beginingDate:Date = Date()
    @State private var endingDate:Date = Date()

    @State private var showCreator:Bool = false
    private var benevoleIntent:BenevoleIntent?
    
    init(festival: FestivalModel,isAdmin:Bool,benevoleIntent:BenevoleIntent?, festivalIntent:FestivalIntent?) {
        self.festivalIntent = festivalIntent
        self.isAdmin=isAdmin
        self.festival=festival
        let festivalDayListLoader:FestivalDayListModel = FestivalDayListModel(festivalDays:[])
        let festivalDayListIntentLoader:FestivalDayListIntent = FestivalDayListIntent(festivalDays:festivalDayListLoader)
        self.festivalDayList = festivalDayListLoader
        self.festivalDayListIntent = festivalDayListIntentLoader
        self.benevoleIntent=benevoleIntent
        self.dateFormatter.dateFormat = "EEEE d MMM yyyy"
    }

    var body: some View {
        

        VStack(alignment: .center, spacing: 20){

            if(festivalDayList.festivalDays.count>0){
                    List(festivalDayList.festivalDays){festivalDay in
                        if(isAdmin){
                            NavigationLink(destination:FestivalDayDetailView(festivalDay: festivalDay,festivalDayListIntent: festivalDayListIntent,festival:festival,festivalIntent: festivalIntent!)){
                                VStack(alignment: .leading){
                                    Text(festivalDay.nom)
                                    Text(dateFormatter.string(from: festivalDay.beginingdate))
                                }
                            }
                        }
                            else{
                                NavigationLink(destination:BenevoleCreneauxListView(festivalDay: festivalDay,benevoleIntent: benevoleIntent!)){
                                    Text(festivalDay.nom)
                            }
                        }
                }
            }
            else{
                Text("No days for the moment").bold().multilineTextAlignment(.center).frame(maxWidth: .infinity, maxHeight:50)
            }
            if(isAdmin){
                Button("Add a day"){
                    showCreator = true
                    
                }.popover(isPresented: $showCreator){
                    
                    Section{
                        Text("Add a day").bold().multilineTextAlignment(.center).frame(maxWidth: .infinity, maxHeight:50).font(.title)
                        VStack{
                            HStack{
                                Text("Name: ")
                                TextField("", text: $newFestivalDayName)
                            }
                            DatePicker("Starting Date",
                                       selection:$beginingDate,
                                       displayedComponents: [.date, .hourAndMinute]).datePickerStyle(GraphicalDatePickerStyle())
                                .labelsHidden()
                                .onAppear {
                                    let formatter = DateFormatter()
                                    formatter.dateFormat = "HH:mm"
                                    formatter.locale = Locale(identifier: "fr_FR")
                                    UIDatePicker.appearance().locale = Locale(identifier: "fr_FR")
                                    UIDatePicker.appearance().minuteInterval = 15
                                    UIDatePicker.appearance().datePickerMode = .time
                                    UIDatePicker.appearance().calendar = .current
                                    UIDatePicker.appearance().timeZone = .current
                                    UIDatePicker.appearance().backgroundColor = .white
                                    UIDatePicker.appearance().tintColor = .black
                                }
                            
                            DatePicker("Ending",
                                       selection:$endingDate,
                                       displayedComponents: [.hourAndMinute]
                            ).datePickerStyle(GraphicalDatePickerStyle())
                                .labelsHidden()
                                .onAppear {
                                    let formatter = DateFormatter()
                                    formatter.dateFormat = "HH:mm"
                                    formatter.locale = Locale(identifier: "fr_FR")
                                    UIDatePicker.appearance().locale = Locale(identifier: "fr_FR")
                                    UIDatePicker.appearance().minuteInterval = 15
                                    UIDatePicker.appearance().datePickerMode = .time
                                    UIDatePicker.appearance().calendar = .current
                                    UIDatePicker.appearance().timeZone = .current
                                    UIDatePicker.appearance().backgroundColor = .white
                                    UIDatePicker.appearance().tintColor = .black
                                }
                            
                        }.onChange(of:endingDate) { newValue in
                            if beginingDate.addingTimeInterval(2*60*60) > endingDate {
                              
                                endingDate = beginingDate.addingTimeInterval(2*60*60)
                               
                            }
                        }.onAppear(){
                            endingDate = beginingDate.addingTimeInterval(2*60*60)
                        }
                        .onChange(of: beginingDate){ newValue in
                            if newValue.addingTimeInterval(2*60*60) > endingDate {
                               
                                endingDate = beginingDate.addingTimeInterval(2*60*60)
                                
                            }
                        }

                        Button("Add day"){
                            festivalDayListIntent.addDay(festival:festival,name:newFestivalDayName,beginingDate:beginingDate,endingDate:endingDate)
                            showPopover.toggle()
                            showCreator = false
                        }.disabled(newFestivalDayName.isEmpty)
                    }

                    
                }
            }
            
        }.onAppear{
            festivalDayListIntent.getFestivalDays(festival: festival)
        }.toast(isPresenting: $showPopover){
            AlertToast(type: .regular, title: "Day created !")
        }.background(Color.white)
    }
    
}
