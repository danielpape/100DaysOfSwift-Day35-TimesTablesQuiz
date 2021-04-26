//
//  ContentView.swift
//  TimesTablesQuiz
//
//  Created by Daniel Pape on 20/04/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTimesTable = 2
    @State private var questions = ["5","10","20","All"]
    @State private var selectedQuestion = 1
    
    @State private var activeQuestion = 1
    @State private var answer = "0"

    @State private var quizActive = false
    
    var body: some View {
        Group{
            ZStack{
                NavigationView{
                    if(quizActive){
                        Form{
                            Section{
                        Text("What is 2x2?")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                TextField("Enter your answer",text: $answer)
                                    .keyboardType(.numberPad)
                            .navigationTitle("Question \(activeQuestion)")
                            }
                        }
                    }else{
                    Form{
                        Section(header:Text("Which times table?")){
                            Stepper(value: $selectedTimesTable, in: 2...12){
                                Text("\(selectedTimesTable)")
                            }
                        }
                        Section(header:Text("How many questions?")){
                            Picker("How many questions?", selection: $selectedQuestion){
                                ForEach(0..<4){
                                    Text("\(self.questions[$0])")
                                }
                                
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }

                    }.navigationTitle("Times Tables")
                        
                    }
                    
                    
                    
                }
                VStack{
                    Spacer()
                    if(!quizActive){
                Button("Start Quiz"){
                    quizActive.toggle()
                }
                .frame(maxWidth: 160)
                .padding(.all)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(40)
                .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                } else {
                    Button("Enter Answer"){
                        activeQuestion += 1
                    }
                    .frame(maxWidth: 160)
                    .padding(.all)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(40)
                    .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                }
                }.padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
