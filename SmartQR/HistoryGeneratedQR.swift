//
//  HistoryGeneratedQR.swift
//  SmartQR
//
//  Created by Leonid Zemtsov on 16.01.2022.
//

import Foundation
import SwiftUI


//Класс с данными
class History: ObservableObject {

    @Published var historyQR: [String] = ["1", "2", "3"]
    

}
    
    
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
    
        
        
//Просмотр старого QR
struct HistoryView: View {
    let QR: QR
    
    
    @State private var isShowingSharingSheet = false
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section() { //Имя QR
                        
                        
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
                                //Закрытие View
                                presentationMode.wrappedValue.dismiss()
                                
                                
                                //Удаление значения
                                
                            }.foregroundColor(.red)
                                .allowsHitTesting(false)
                            Spacer()
                        }
                    }
                    
                    
                }
            }.navigationBarTitle("\(QR.name)")
        }
        
    }
}






