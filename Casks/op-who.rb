cask "op-who" do
  version "1.0.0"
  sha256 :no_check

  url "https://github.com/sunstoneinstitute/op-who/releases/download/v#{version}/op-who.zip"
  name "op-who"
  desc "Shows which process triggered a 1Password approval dialog"
  homepage "https://github.com/sunstoneinstitute/op-who"

  app "op-who.app"

  zap trash: [
    "~/Library/Preferences/ai.sunstoneinstitute.op-who.plist",
  ]
end
