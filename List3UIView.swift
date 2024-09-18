//
//  List3UIView.swift
//  BaseProject
//
//  Created by user on 06.09.2024.
//

import SwiftUI

struct Item: Identifiable{
  var id = UUID()
  var name:String
}

struct UpdateStateProperty: View {

  var items:[Item] = [Item(name: "Oranges"),
            Item(name: "Apples"),
            Item(name: "Cookies") ]

  @State private var presentView = false
  @State private var selectedItem: Item?

  var body: some View {
    List{
      ForEach(items){ item in
        HStack{
          Text(item.name)

        }.onTapGesture {
          selectedItem = item
          presentView.toggle()
        }
      }
    }
    .sheet(isPresented: $presentView){
        MySheetView(selectedItem: $selectedItem)
    }
  }
}

struct MySheetView: View {
    @Binding var selectedItem: Item?
    
    var body: some View {
        Text("\(selectedItem?.name ?? "*nil*")")
    }
}

#Preview {
    UpdateStateProperty()
}
