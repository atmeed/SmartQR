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
       @State var isPresentingChoise = false
    
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
                       if (code.string != "") {
                           history.historyQR.append(code.string)
                       }
                       
                   }
               }
           )
       }
    
       
       
       //BODY
       var body: some View {
           NavigationView {
               
               Form {
                   
                   
                   
                   
                   //Бар с кнопками
                   Section {
                       Group {
                           
                           //Сканирование фото
                           Button(action: {
                               self.isPresentingScanner = true

                           }) {
                               HStack {
                                   Spacer()
                                   Image(systemName: "qrcode")
                                   Text("Сканирование кода")
                                   Spacer()
                               }
                                .font(.title2)
                                .padding(.horizontal)

                           }.sheet(isPresented: $isPresentingScanner) {
                               self.scannedSheet
                           }.padding(15)
                           
                           //Выбрать фото
                           Button(action: {
                               

                           }) {
                               HStack {
                                   Spacer()
                                   Image(systemName: "photo.on.rectangle.angled")
                                   Text("Выбрать фото")
                                   Spacer()
                               }
                                .font(.title2)
                                .padding(.horizontal)

                           }.padding(15)
                           
                           //
                           
                           
                           
                           
                           
                           

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
                           HStack {
                               Spacer()
                               Button("Удалить все") {
                                   history.historyQR = []
                               }.foregroundColor(.red)
                               Spacer()
                           }
                           
                           
                       }
                   } else {
                       Section(header: Text("Вы еще не сканировали QR")) {
                           
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
