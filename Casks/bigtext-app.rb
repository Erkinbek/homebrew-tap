# BigText.app for the Applications folder, with bigtext-cli on the PATH. The tap's update
# workflow keeps `version` and the checksums at the latest release.
cask "bigtext-app" do
  arch arm: "arm64", intel: "x64"

  version "0.12.0"
  sha256 arm:   "2228d3d6e7c52ee2ad3735ae0665f3857697a9394226b188b436544378f737e1",
         intel: "ebd7cba259991c710d037afdc1c76a56880c3eab12c5b962615efae75366e42e"

  url "https://github.com/Erkinbek/bigtext/releases/download/v#{version}/bigtext-macos-#{arch}.app.zip"
  name "BigText"
  desc "Text editor for huge files that never loads them into memory"
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
