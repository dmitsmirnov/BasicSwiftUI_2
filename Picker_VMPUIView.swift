//
//  PickerUIView.swift
//  vmpauto.S
//
//  Created by user on 20.03.2024.
//

import SwiftUI

struct DataModel: Codable, Identifiable, Hashable {
    
    var id = UUID()
    let uid: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case uid = "УИД"
        case name = "Наименование"
    }
    
}

class Api {
    
    func getPost(completion: @escaping ([DataModel]) -> ()) {
        
        let url = "http://192.168.3.40:8091/db_unf/hs/views/app/getTypeOfGroup"
        
        guard let url = URL(string: url) else {
            print("Error: cannot create URL")
            //completion([])
            return
        }
        
        var request = URLRequest(url: url)
        let username = "Смирнов Дмитрий"
        let password = "123"
        let loginString = "\(username):\(password)"
        
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            //completion([])
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        
        request.httpMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedData = try? JSONDecoder().decode([DataModel].self, from: data) {
                    DispatchQueue.main.async {
                        completion(decodedData)
                    }
                }
                
            }
        }.resume()
    }
    
}

    
    


struct Picker_VMPUIView: View {
    
    
    var jsonDecoder: JSONDecoder = JSONDecoder()
    
    //func getGroupfetch(completion: @escaping ([DataModel]) -> Void) {
    func getGroupfetch() {
        
        let url = "http://192.168.3.40:8091/db_unf/hs/views/app/getTypeOfGroup"
        
        guard let url = URL(string: url) else {
            print("Error: cannot create URL")
            //completion([])
            return
        }
        
        var request = URLRequest(url: url)
        let username = "Смирнов Дмитрий"
        let password = "123"
        let loginString = "\(username):\(password)"
        
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            //completion([])
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        
        request.httpMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedData = try? JSONDecoder().decode([DataModel].self, from: data) {
                    DispatchQueue.main.async {
                        self.dataSource = decodedData
                    }
                }
                
            }
        }.resume()
    }
     
    
    @State private var selectedGroup = 2
    //@State var selectedGroup: DataModel?
    @State var dataSource: [DataModel] = [DataModel(uid: "1", name: "1"),
                                          DataModel(uid: "2", name: "2"),
                                          DataModel(uid: "3", name: "3"),
                                          DataModel(uid: "4", name: "4"),
                                          DataModel(uid: "5", name: "5")]
//    @State var dataSource: [DataModel] = []
    
   
    
    var body: some View {
        
        NavigationStack {

//            ForEach(self.dataSource) { data in
//                Text(data.name)
//            }
            
            Form {
                Section {
                    
                    Picker(selection: $selectedGroup, label: Text("Вид товара")) {
                        
//                        ForEach(dataSource) { data in
//                            Text(data.name)
//                        }
                        
                        ForEach(0..<dataSource.count) {
                            Text(self.dataSource[$0].name)
                        }
                    }

                    .pickerStyle(.navigationLink)
                    .onAppear() {
                        Api().getPost { (dataSource) in
                            self.dataSource = dataSource
                        }
                    }
                
                }
                
                //Text("Choose - \(self.dataSource[selectedGroup].name)")
                Text("\(selectedGroup)")
                
            }
            
        }
        .onAppear {
            //fillDataSource()
            //self.getGroupfetch()
            
        }
    }
    
}

#Preview {
    Picker_VMPUIView()
}
