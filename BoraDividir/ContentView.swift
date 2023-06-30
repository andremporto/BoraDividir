//
//  ContentView.swift
//  BoraDividir
//
//  Created by André Porto on 30/06/23.
//

import SwiftUI

struct ContentView: View {
    
//    let background =  Color(.blue)
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [0, 10, 15, 20, 25]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.red]),
                               startPoint: .topLeading,
                               endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    Form {
                        Section {
                            TextField("Quantidade", value: $checkAmount, format:
                                    .currency(code: Locale.current.currency?.identifier ?? "BRL"))
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                            
                            Picker("Quantidade de pessoas:", selection: $numberOfPeople) {
                                ForEach(2..<100) {
                                    Text("\($0) pessoas")
                                }
                            }
                        } header: {
                            Text("Valor e quantidade de pessoas")
                        }
                        
                        Section {
                            Picker("Porcentagem da Gorjeta", selection: $tipPercentage) {
                                ForEach(tipPercentages, id: \.self) {
                                    Text($0, format: .percent)
                                }
                            }
                            .pickerStyle(.segmented)
                        } header: {
                            Text("Quanto você quer dar de gorjeta?")
                        }
                        
                        Section {
                            Text(totalPerPerson, format:
                                    .currency(code: Locale.current.currency?.identifier ?? "BRL"))
                        } header: {
                            Text("Valor por pessoa")
                        }
                    }
                    .scrollContentBackground(.hidden)
                    
                    .navigationTitle("BoraDividir")
                    //Keyboard buttom
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            
                            Button("Fechar") {
                                amountIsFocused = false
                            }
                        }
                    }
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
