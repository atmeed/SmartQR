//
//  ContentView.swift
//  SmartQR
//
//  Created by Leonid Zemtsov on 12.01.2022.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        TabView{
            GeneratorQR().tabItem {
                Image(systemName: "qrcode")
                Text("Создание")
            }
            ScannerQR().tabItem {
                Image(systemName: "qrcode.viewfinder")
                Text("Сканирование")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
