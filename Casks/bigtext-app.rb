# BigText.app for the Applications folder, with bigtext-cli on the PATH. The tap's update
# workflow keeps `version` and the checksums at the latest release.
cask "bigtext-app" do
  arch arm: "arm64", intel: "x64"

  version "0.7.1"
  sha256 arm:   "b3546328faeedc033bb807ac2ccfebc805647139f0deb7bee4c5c8615dd0f1c0",
         intel: "0d04b1f3e94a84c3cbe3f1a4cdfe02eb26c55263b3f6bc4f8fc7de8d707ba2a9"

  url "https://github.com/Erkinbek/bigtext/releases/download/v#{version}/bigtext-macos-#{arch}.app.zip"
  name "BigText"
  desc "Text editor for huge files that never freezes"
  homepage "https://erkinbek.github.io/bigtext/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :big_sur"

  app "BigText.app"
  binary "#{appdir}/BigText.app/Contents/MacOS/bigtext-cli"

  zap trash: "~/Library/Application Support/BigText"

  caveats <<~EOS
    BigText is not signed. If macOS refuses to open it, run once:
      xattr -dr com.apple.quarantine "#{appdir}/BigText.app"
    Or install the command-line build instead, which macOS opens without asking:
      brew install erkinbek/tap/bigtext
  EOS
end
