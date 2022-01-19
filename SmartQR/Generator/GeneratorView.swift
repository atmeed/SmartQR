//
//  GeneratorView.swift
//  SmartQR
//
//  Created by Leonid Zemtsov on 15.01.2022.
//

import SwiftUI





//BODY
struct GeneratorView: View {
    
    @ObservedObject var history = History(history: ["1", "2", "3"])
    
    
    

    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    //Последний QR
                    if history.historyQR.count > 0 {
                        
                        LastQR(QR: StringToQR(name: history.historyQR[Int(exactly: history.historyQR.count)!-1]))
                            .navigationBarTitle("Последний QR")
                    } else {
                        Section {
                            //Пример
                            Image(systemName: "qrcode")
                                .resizable()
                                .scaledToFit()
                                .navigationBarTitle("Создание QR")
                                .padding()
                        }
     
                    }
                    
                    //Создание QR
                    Section(header: Text("Создание QR")) {
                        Group {
                            
                            //Создание QR из текста
                            Button(action: {
                                
                                
                            }) {
                                HStack {
                                    Spacer()
                                    Image(systemName: "text.viewfinder")
                                    Text("Текст")
                                    Spacer()
                                }
                                .foregroundColor(.black)
                                .font(.title2)
                                .padding(.horizontal)
                                
                            }.padding(15)
                            
                            
                            //Создание QR из Фото
                            Button(action: {
                                
                                
                            }) {
                                HStack {
                                    Spacer()
                                    Image(systemName: "photo.on.rectangle.angled")
                                    Text("Фото")
                                    Spacer()
                                }
                                .foregroundColor(.black)
                                .font(.title2)
                                .padding(.horizontal)
                                
                            }.padding(15)
                            
                            
                             
                        }
                    }
                    
                    
                    //История создания QR
                    if history.historyQR.count > 0 { //Удаление истории приводит к удалению всего View
                        Section(header: Text("История")) {
                            List {
                                ForEach(history.historyQR, id: \.self) { qr in
                                    NavigationLink(destination: HistoryView(QR: StringToQR(name: qr))) {
                                        HistoryRow(QR: StringToQR(name: qr))
                                    }
                                }
                            }
                            HStack {
                                Spacer()
                                Button("Удалить все") {
                                    history.historyQR = []
                                }.foregroundColor(.red)
                                Spacer()
                            }
                            
                            
                        }
                    } else {
                        Section(header: Text("Вы еще не создавали QR")) {
                            
                        }
                    }
                    
                }
            }.navigationTitle("Создание QR")
            
        }
        
    }
}

struct GeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        GeneratorView()
    }
}
