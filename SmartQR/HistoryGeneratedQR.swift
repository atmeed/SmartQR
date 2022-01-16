//
//  HistoryGeneratedQR.swift
//  SmartQR
//
//  Created by Leonid Zemtsov on 16.01.2022.
//

import Foundation
import SwiftUI

class History: ObservableObject {
    
    
    
    
    //Строчки в Истории
    struct HistoryRow: View {
        
        var QR: QR
        
        var body: some View {
            HStack {
                Image(uiImage: QR.image)
                Text(QR.name)
                
            }
        }
    }
    
    //Список в главном View
    struct HistoryList: View {
        
        var historyQR: [String]
        
        var body: some View {
            List {
                ForEach(historyQR, id: \.self) { qr in
                    NavigationLink(destination: HistoryView(QR: StringToQR(name: qr))) {
                        History.HistoryRow(QR: StringToQR(name: qr))
                    }
                }
            }
        }
        
        
        //Просмотр старого QR
        struct HistoryView: View {
            let QR: QR
            
            @State private var isShowingSharingSheet = false
            
            
            var body: some View {
                VStack {
                    Form {
                        Section(header: Text("\(QR.name)")) { //Имя QR
                            
                            
                            //Изображение самого QR
                            Image(uiImage: QR.image)
                                .interpolation(.none)
                                .resizable()
                                .scaledToFit()
                            
                            //Кнопка поделиться
                            HStack {
                                Spacer()
                                Button("Поделиться") {
                                    self.isShowingSharingSheet = true
                                }.sheet(isPresented: $isShowingSharingSheet, content: {
                                    ShareSheet(activityItems: [QR.image], applicationActivities: nil)
                                })
                                    .padding(.bottom, 10)
                                    .padding(.top, 10)
                                Spacer()
                            }
                        }
                        Section {
                            HStack {
                                Spacer()
                                Button("Удалить") {
                                    
                                }.foregroundColor(.red)
                                Spacer()
                            }
                        }
                        
                        
                    }
                }
            }
        }
    }
}




