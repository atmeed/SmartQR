//
//  ScannerQR.swift
//  SmartQR
//
//  Created by Leonid Zemtsov on 12.01.2022.
//

import SwiftUI
import CodeScanner

struct ScannerView: View {
    
       //Сканер
       @State var isPresentingScanner = false
       @State var scannedCode: String = "Scan QR code to get started"
    
        //История
        @ObservedObject var history = History(history: ["1", "2"])
       
    
       //Сам сканер
       var scannedSheet: some View {
           CodeScannerView (
               codeTypes: [.qr],
               completion:  { result in
                   if case let .success(code) = result {
                       self.scannedCode = code.string
                       self.isPresentingScanner = false
                   }
               }
           )
       }
    
       
       
       //BODY
       var body: some View {
           NavigationView {
               
               VStack(spacing: 10) {
                   //Вверхний бар
                   VStack {
                       Text(scannedCode)
                   }.padding(.vertical, 130)
                   Spacer()
                   
                   
                   
                   //Бар с кнопками
                   VStack {
                       HStack(spacing: 13) {
                           
                           //Сканирование из камеры
                           Button("Scan QR") {
                               self.isPresentingScanner = true
                           }
                           .sheet(isPresented: $isPresentingScanner) {
                               self.scannedSheet
                               }
                           
                           
                           //Сканирование с фотографии
                           Button("Select a photo") {
                               
                           }

                       }

                   }
                   
                   //История сканирования QR
                   if history.historyQR.count > 0 { //Удаление истории приводит к удалению всего View
                       Section(header: Text("История")) {
                           List {
                               ForEach(history.historyQR, id: \.self) { qr in
                                   NavigationLink(destination: HistoryView(QR: StringToQR(name: qr))) {
                                       HistoryRow(QR: StringToQR(name: qr))
                                   }
                               }
                           }
                           
                           //Удаление всей истории QR
                           HStack{
                               Button("Удалить всю истроию") {
                                   history.historyQR = []
                                   
                               }
                               .foregroundColor(.red)
                               
                                   
                           }
                       }
                   }
                   
                   
                   
                   
                   
               }.navigationBarTitle("Сканер QR кодов")
               
           }
       }
}

struct ScannerQR_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
