//
//  ContentView.swift
//  TimesTablesQuiz
//
//  Created by Daniel Pape on 20/04/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTimesTable = 5
    @State private var questions = ["5","10","20"]
    @State private var selectedQuestion = 1
    
    @State private var activeQuestion = 1
    @State private var answer = ""
    @State private var correctAnswers = 0


    @State private var multipliedBy = Int.random(in: 1...10)
    @State private var quizActive = false
    
    @State private var showingResults = false
    @State private var endMessage = ""
    
    func reset(){
        answer = ""
        showingResults = false
        quizActive = false
        activeQuestion = 1
        correctAnswers = 0
    }
    
    func setEndText(){
        if(correctAnswers == Int(questions[selectedQuestion])){
            endMessage = "A perfect score!"
            return
        }
        if(correctAnswers > Int(questions[selectedQuestion])!/2){
            endMessage = "Great Score! Well done!"
            return
        }
        if(correctAnswers >= 3){
            endMessage = "Please keep practising!"
            return
        }
    }
    
    func submitAnswer(){
        if(Int(answer) == selectedTimesTable * multipliedBy ){
            correctAnswers += 1
        }
        if (activeQuestion == Int(questions[selectedQuestion])){
            setEndText()
            showingResults.toggle()
            quizActive = false
        }
        answer = ""
        activeQuestion += 1
        multipliedBy = Int.random(in: 1...10)
    }
    
    var body: some View {
        Group{
            ZStack{
                NavigationView{
                    if(quizActive){
                        Form{
                            Section{
                        Text("What is \(selectedTimesTable)x\(multipliedBy)?")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                TextField("Enter your answer",text: $answer)
                                    .keyboardType(.numberPad)
                            .navigationTitle("Question \(activeQuestion)")
                                    .navigationBarItems(trailing: Text("\(correctAnswers) / \(activeQuestion-1)"))
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
                                ForEach(0..<questions.count){
                                    Text("\(self.questions[$0])")
                                }
                                
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }

                    }.navigationTitle("Times Tables")
                        
                    }
                    
                    
                    
                }
                .alert(isPresented: $showingResults, content: {
                    Alert(title: Text("You got \(correctAnswers) out of \(questions[selectedQuestion])"), message: Text("\(endMessage)"), dismissButton: .default(Text("OK"),action: reset))
                })
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
                        submitAnswer()
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
