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
            GeneratorView().tabItem {
                Image(systemName: "qrcode")
                Text("Создание")
            }
            ScannerView().tabItem {
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
