//
//  SearchUIView.swift
//  BaseProject
//
//  Created by user on 13.09.2024.
//

import SwiftUI

struct CityModel: Identifiable {
    var id = UUID().uuidString
    var uid: String
    var name: String
}

struct SearchUIView: View {
    
    @State private var selectedCity: CityModel? = nil
    @State private var showCityList = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Настройки") {
                    // Выбор компании
                    Button(action: {
                        showCityList = true
                    }) {
                        Text(selectedCity?.name ?? "Выберите компанию")
                            .foregroundColor(.blue)
                    }
                    .sheet(isPresented: $showCityList) {
                        CityListView(selectedCity: $selectedCity)
                    }
                }
            }
            .navigationTitle("Выбор компании")
        }
    }
}

struct CityListView: View {
    
    @Binding var selectedCity: CityModel?
    @State private var searchText = ""
    
    @State private var listCompany: [CityModel] = [
        CityModel(uid: "1", name: "test"),
        CityModel(uid: "2", name: "aaa"),
        CityModel(uid: "3", name: "bbb"),
        CityModel(uid: "4", name: "ccc"),
        CityModel(uid: "5", name: "yyy"),
    ]
    
    // Отфильтрованный список компаний
    var filteredCompanies: [CityModel] {
        if searchText.isEmpty {
            return listCompany
        } else {
            return listCompany.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        NavigationStack {
            List {
                Section(header: Text("Поиск")) {
                    HStack {
                        Image(systemName: "viewfinder")
                        TextField("Поиск компании", text: $searchText)
                        //.textFieldStyle(RoundedBorderTextFieldStyle())
                        //.padding(.vertical)
                    }
                }
                
                Section("Компании") {
                    ForEach(filteredCompanies) { item in
                        Button(action: {
                            selectedCity = item
                            // Закрытие текущего экрана
                            //UIApplication.shared.sendAction(#selector(NSResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text(item.name)
                        }
                    }
                }
            }
            .navigationTitle("Выбор компании")
        }
    }
}

#Preview {
    SearchUIView()
}
