cask "network-device-status" do
  version "0.1.2"
  sha256 "2368ef3c1388532ef6c2bdf10e46c0f341378353ebde4f6b8f14663e6dd4ffb4"

  url "https://github.com/comatory/network-device-status/releases/download/#{version}/Network.Device.Status.zip"
  name "Network Device Status"
  desc "macOS menu bar app showing network device status"
  homepage "https://github.com/comatory/network-device-status"

  app "Network Device Status.app"

  zap trash: [
    "~/Library/Application Support/com.comatory.network-device-status",
    "~/Library/Preferences/com.comatory.network-device-status.plist",
  ]
end
