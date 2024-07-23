//
//  GetFuncUIView.swift
//  BaseProject
//
//  Created by user on 17.07.2024.
//

import SwiftUI

struct GetFuncUIView: View {
    
    struct Data: Identifiable, Hashable {
        var id = UUID().uuidString
        var name: Double
    }
    
    @State var list: [Data] = [Data(name: 1),
                               Data(name: 5),
                               Data(name: 4),
                               Data(name: 3),
                               Data(name: 2)]
    
    
    //@ViewBuilder
    //func addNew() -> some View {
    func addNew() {
        self.list.append(Data(name: 7))
    }
    
    var body: some View {
        
        VStack {
            
            List {
                ForEach(list, id: \.self) { item in
                    Text(String(item.name))
                }
            }
            //AddButton(mainStruct: $self)
             
            Button(action: {self.list.sort { $0.name > $1.name }}, label: {Text("Sort")})
            
        }
        
    }
}

struct AddButton: View {
     
    //@Environment var mainStruct: GetFuncUIView
    @Binding var mainStruct: GetFuncUIView
    
    var body: some View {
        
        Button(action : {
            //self.addNew()
            mainStruct.addNew()
        }) {
            Text("ADD outside")
        }
        .padding()
        
    }
    
}

#Preview {
    GetFuncUIView()
}
