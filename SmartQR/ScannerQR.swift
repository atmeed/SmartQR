//
//  ScannerQR.swift
//  SmartQR
//
//  Created by Leonid Zemtsov on 12.01.2022.
//

import SwiftUI
import CodeScanner

struct ScannerQR: View {
       @State var isPresentingScanner = false
       @State var scannedCode: String = "Scan QR code to get started"
       
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
       
       
       
       var body: some View {
           NavigationView {
               
               VStack(spacing: 10) {
                   //Вверхний бар
                   VStack {
                       Text(scannedCode)
                   }.padding(.vertical, 130)
                   Spacer()
                   
                   //Нижний бар с кнопками
                   VStack {
                       HStack(spacing: 13) {
                           
                           //Сканирование из камеры
                           Button("Scan QR") {
                               self.isPresentingScanner = true
                           }
                           .foregroundColor(.white)
                           .font(.system(size: 22))
                           .padding()
                           .padding(.horizontal, 27)
                           .background(Color.gray)
                           .clipShape(RoundedRectangle(cornerRadius: 15 ))
                           .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 3))
                           
                           
                           
                           .sheet(isPresented: $isPresentingScanner) {
                               self.scannedSheet
                               }
                           
                           
                           //Сканирование с фотографии
                           Button("Select a photo") {
                               
                           }
                           .font(.system(size: 22))
                           .foregroundColor(.white)
                           .padding()
                           .background(Color.green)
                           .clipShape(RoundedRectangle(cornerRadius: 15 ))
                           .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 3))
                           
                       }
                       
                       //Кнопка с пояснениями как и что работает
                       Button(action: {
                           
                       }) {
                           Image(systemName: "questionmark.circle")
                       }
                       .foregroundColor(.gray)
                       .padding(.bottom, 10)
                       .padding(.top, 5)
                   }
               }.navigationBarTitle("Сканер QR кодов")
               
           }
       }
}

struct ScannerQR_Previews: PreviewProvider {
    static var previews: some View {
        ScannerQR()
    }
}
