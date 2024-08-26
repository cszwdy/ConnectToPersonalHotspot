//
//  ContentView.swift
//  ConnectToPersonalHotspotApp
//
//  Created by Emiaostein on 2024/8/26.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var isConnecting = false
    @State private var connectionStatus = "Ready to connect"
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Hotspot Connector")
                .font(.title)
            
            Button(action: {
                connectToHotspot()
            }) {
                Text(isConnecting ? "Connecting..." : "Connect to Hotspot")
                    .frame(minWidth: 200)
            }
            .disabled(isConnecting)
            
            Text(connectionStatus)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(width: 300, height: 200)
    }
    
    func connectToHotspot() {
        isConnecting = true
        connectionStatus = "Attempting to connect..."
        
        DispatchQueue.global(qos: .background).async {
            let script = getHotspotScript()
            
            let task = Process()
            task.launchPath = "/bin/bash"
            task.arguments = ["-c", script]
            
            let pipe = Pipe()
            task.standardOutput = pipe
            task.standardError = pipe
            
            task.launch()
            task.waitUntilExit()
            
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            if let output = String(data: data, encoding: .utf8) {
                print(output)
                DispatchQueue.main.async {
                    self.connectionStatus = "Connection attempt completed. Check Console for details."
                    self.isConnecting = false
                }
            }
        }
    }
    
    func getHotspotScript() -> String {
        return """
        #!/bin/bash

        # 设置热点名称和密码

        SSID="HONOR V20"
        PASSWORD="czh906663"

        MAX_RETRIES=10
        RETRY_DELAY=5

        # 查找Wi-Fi接口
        WIFI_INTERFACE=$(networksetup -listallhardwareports | awk '/Wi-Fi/{getline; print $2}')

        if [ -z "$WIFI_INTERFACE" ]; then
            echo "未找到Wi-Fi接口"
            exit 1
        fi

        attempt=0
        while [ $attempt -lt $MAX_RETRIES ]; do
            result=$(networksetup -setairportnetwork "$WIFI_INTERFACE" "$SSID" "$PASSWORD" 2>&1)
            exit_code=$?
            
            echo "reuslt = [$result]"
            
            if [ $exit_code -eq 0 ] && [ "$result" = "" ]; then
                echo "成功连接到 $SSID"
                exit 0
            else
                attempt=$((attempt+1))
                echo "连接失败（尝试 $attempt/$MAX_RETRIES）：$result"
                if [ $attempt -lt $MAX_RETRIES ]; then
                    echo "等待 $RETRY_DELAY 秒后重试..."
                    sleep $RETRY_DELAY
                fi
            fi
        done

        echo "达到最大重试次数。连接失败。"
        exit 1
        """
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
