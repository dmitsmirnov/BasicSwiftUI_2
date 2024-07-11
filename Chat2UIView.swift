//
//  Chat2UIView.swift
//  BaseProject
//
//  Created by user on 11.07.2024.
//

import SwiftUI
import Charts

struct Chat2UIView: View {
    
    struct DataModel: Identifiable {
        let id = UUID().uuidString
        var name: String
        var value: Int
        var color: Color
        var extraText: String
    }
    
    @State private var arrayData: [DataModel] = [DataModel(name: "1", value: 100, color: .red, extraText: "test 1"),
                                                 DataModel(name: "2", value: 200, color: .green, extraText: "test 2"),
                                                 DataModel(name: "3", value: 300, color: .orange, extraText: "test 3"),
                                                 DataModel(name: "4", value: 250, color: .blue, extraText: "test 4"),
                                                 DataModel(name: "5", value: 150, color: .yellow, extraText: "test 5")]
    @State private var lineSection: String?
    @State private var selectedValue: DataModel?
    
    @State private var isOpenSheet: Bool = false
    
    @State private var example: Bool = false
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                Spacer()
                
                Button(action: {
                    isOpenSheet.toggle()
                }, label: {
                    Image(systemName: "gear")
                })
                .sheet(isPresented: $isOpenSheet) {
                    SheetView(example: $example)
                        .presentationDetents([.height(300)])
                }
                
            }
            .padding(.horizontal)
            
            
            
            Chart {
                
                ForEach (arrayData) { element in
                    
                    BarMark(x: .value("x", element.name),
                            y: .value("y", element.value)
                    )
                    //.foregroundStyle(by: .value("x", element.name))
                    .foregroundStyle( selectedValue?.name != element.name ? Color.gray.gradient : element.color.gradient)
                    //.offset(x: 10, y: 10)
                    .opacity(0.7)
                    //.shadow(radius: 5)
                    .blur(radius: selectedValue?.name != element.name ? 2 : 0)
                    .annotation {
                        Text("\(element.value)")
                    }
                    
                }
                
//                if let lineSection {
//                    
//                    
//                    if let element = arrayData.first(where: { $0.name == lineSection }) {
//                        
//                        
//                        RuleMark(x: .value("name", lineSection))
//                            .foregroundStyle(.blue.opacity(0.35))
//                            .lineStyle(.init(lineWidth: 2, miterLimit: 2, dash: [2]))
//                            .annotation(position: .trailing, spacing: 0, overflowResolution: .init(x: .disabled, y: .disabled)) {
//                                
//                                Text(lineSection)
//                                
//                            }
//                    }
//                    
//                }
                
            }
            .frame(height: 300)
            .padding()
            .chartXSelection(value: $lineSection)
            .onChange(of: lineSection) { oldvalue, newValue in
                if let newValue {
                    getSelectedValue(name: newValue)
                }
            }
            
//            if let element = arrayData.first(where: { $0.name == lineSection }) {
//                
//                VStack {
//                    Text(String(lineSection!))
//                    //Text(value)
//                    //Text(String(element.value))
//                }
//                
//            }
            
            if let selectedValue {
                Text(selectedValue.extraText)
            }
            
            if example {
                Text("it's work it")
                    .font(.largeTitle)
                    .padding()
            }
            
            Spacer()
            
        }.onAppear {
            selectedValue = arrayData[0]
        }
    }
    
    private func getSelectedValue(name: String) {
        selectedValue = arrayData.first { $0.name == name }
    }
    
}

struct SheetView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var example: Bool
    
    var body: some View {
        Button("Press to dismiss") {
            dismiss()
            withAnimation {
                example.toggle()
            }
        }
        .font(.title)
        .padding()
    }
}

#Preview {
    Chat2UIView()
}
