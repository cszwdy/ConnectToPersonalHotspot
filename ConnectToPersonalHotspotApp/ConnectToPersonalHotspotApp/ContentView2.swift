//
//  ContentView2.swift
//  ConnectToPersonalHotspotApp
//
//  Created by Emiaostein on 2024/8/26.
//

import SwiftUI
import CoreWLAN

class HotspotConnector: ObservableObject {
    private let client: CWWiFiClient
    @Published var status: String = "准备连接"
    @Published var isScanning: Bool = false
    
    let ssid = "Emiaostein iPhone 11 Pro Navy"
    let password = "88888888"
    
    init() {
        self.client = CWWiFiClient.shared()
    }
    
    func connectToHotspot(ssid: String, password: String) {
        guard let interface = client.interface() else {
            status = "无法获取 WiFi 接口"
            return
        }
        
        isScanning = true
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let networks = try interface.scanForNetworks(withName: ssid)
                
                DispatchQueue.main.async {
                    self.isScanning = false
                    
                    guard let network = networks.first else {
                        self.status = "找不到指定的网络: \(ssid)"
                        return
                    }
                    
                    do {
                        try interface.associate(to: network, password: password)
                        self.status = "成功连接到热点: \(ssid)"
                    } catch {
                        self.status = "连接失败: \(error.localizedDescription)"
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.isScanning = false
                    self.status = "扫描网络失败: \(error.localizedDescription)"
                }
            }
        }
    }
}

struct ContentView2: View {
    @StateObject private var connector = HotspotConnector()
    @State private var ssid: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("个人热点连接")
                .font(.largeTitle)
            
            TextField("热点名称", text: $ssid)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField("密码", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                connector.connectToHotspot(ssid: ssid, password: password)
            }) {
                Text("连接")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(connector.isScanning)
            
            if connector.isScanning {
                ProgressView("正在扫描网络...")
            } else {
                Text(connector.status)
                    .padding()
                    .foregroundColor(connector.status.contains("成功") ? .green : .red)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView2()
}
