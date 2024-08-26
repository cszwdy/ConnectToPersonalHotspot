//
//  ConnectToPersonalHotspotAppApp.swift
//  ConnectToPersonalHotspotApp
//
//  Created by Emiaostein on 2024/8/26.
//

import SwiftUI

@main
struct HotspotConnectorApp: App {
//    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
            ContentView2()
        }
    }
}

//class AppDelegate: NSObject, NSApplicationDelegate {
//    var statusItem: NSStatusItem?
//    
//    func applicationDidFinishLaunching(_ notification: Notification) {
//        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
//        
//        if let button = statusItem?.button {
//            button.image = NSImage(systemSymbolName: "wifi", accessibilityDescription: "Hotspot")
//        }
//        
//        setupMenus()
//    }
//    
//    func setupMenus() {
//        let menu = NSMenu()
//        
//        menu.addItem(NSMenuItem(title: "Connect to Hotspot", action: #selector(connectToHotspot), keyEquivalent: ""))
//        menu.addItem(NSMenuItem.separator())
//        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
//        
//        statusItem?.menu = menu
//    }
//    
//    @objc func connectToHotspot() {
//        let script = getHotspotScript()
//        
//        let task = Process()
//        task.launchPath = "/bin/bash"
//        task.arguments = ["-c", script]
//        
//        let pipe = Pipe()
//        task.standardOutput = pipe
//        task.standardError = pipe
//        
//        task.launch()
//        
//        let data = pipe.fileHandleForReading.readDataToEndOfFile()
//        if let output = String(data: data, encoding: .utf8) {
//            print(output)
//            showNotification(message: "Hotspot connection attempt completed. Check the console for details.")
//        }
//    }
//    
//    func getHotspotScript() -> String {
//        return """
//        #!/bin/bash
//
//        # 设置热点名称和密码
//        SSID="Emiaostein iPhone 11 Pro Navy"
//        PASSWORD="88888888"
//
//        #SSID="HONOR V20"
//        #PASSWORD="********"
//
//        MAX_RETRIES=10
//        RETRY_DELAY=5
//
//        # 查找Wi-Fi接口
//        WIFI_INTERFACE=$(networksetup -listallhardwareports | awk '/Wi-Fi/{getline; print $2}')
//
//        if [ -z "$WIFI_INTERFACE" ]; then
//            echo "未找到Wi-Fi接口"
//            exit 1
//        fi
//
//        attempt=0
//        while [ $attempt -lt $MAX_RETRIES ]; do
//            result=$(networksetup -setairportnetwork "$WIFI_INTERFACE" "$SSID" "$PASSWORD" 2>&1)
//            exit_code=$?
//            
//            echo "reuslt = [$result]"
//            
//            if [ $exit_code -eq 0 ] && [ "$result" = "" ]; then
//                echo "成功连接到 $SSID"
//                exit 0
//            else
//                attempt=$((attempt+1))
//                echo "连接失败（尝试 $attempt/$MAX_RETRIES）：$result"
//                if [ $attempt -lt $MAX_RETRIES ]; then
//                    echo "等待 $RETRY_DELAY 秒后重试..."
//                    sleep $RETRY_DELAY
//                fi
//            fi
//        done
//
//        echo "达到最大重试次数。连接失败。"
//        exit 1
//        """
//    }
//    
//    func showNotification(message: String) {
//        let notification = NSUserNotification()
//        notification.title = "Hotspot Connector"
//        notification.informativeText = message
//        NSUserNotificationCenter.default.deliver(notification)
//    }
//}
