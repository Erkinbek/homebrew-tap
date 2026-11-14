# BigText.app for the Applications folder, with bigtext-cli on the PATH. The tap's update
# workflow keeps `version` and the checksums at the latest release.
cask "bigtext-app" do
  arch arm: "arm64", intel: "x64"

  version "0.11.0"
  sha256 arm:   "f3b3b21a6b00a08107fd4147200545720ca3de16f5467f4754769f2a777f6057",
         intel: "18d8f42c7f3a038e5f6135744fb59b04b8504c0932e6ab8374f1c12d883422cd"

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
