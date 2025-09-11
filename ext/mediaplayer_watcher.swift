import Foundation

func shell(_ args: String) {
    let process = Process()
    process.launchPath = "/bin/zsh"
    process.arguments = ["-c", args]
    process.launch()
}

let center = CFNotificationCenterGetDarwinNotifyCenter()

let callback: CFNotificationCallback = { _, _, name, _, _ in
    if let n = name {
        let notif = n.rawValue as String
        
        if notif.contains("com.apple.MediaRemote.nowPlayingApplicationIsPlayingDidChange") {
            shell("sketchybar --trigger now_playing_change INFO='\(notif)'")
        }
    }
}

CFNotificationCenterAddObserver(center,
                               nil,
                               callback,
                               "com.apple.MediaRemote.nowPlayingApplicationIsPlayingDidChange" as CFString,
                               nil,
                               .deliverImmediately)

RunLoop.main.run()
