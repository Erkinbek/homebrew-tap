# BigText.app for the Applications folder, with bigtext-cli on the PATH. The tap's update
# workflow keeps `version` and the checksums at the latest release.
cask "bigtext-app" do
  arch arm: "arm64", intel: "x64"

  version "0.8.1"
  sha256 arm:   "a081a976a0c2da6f6612173b672432a3668b61836015e67b42bdc03a91cc08e2",
         intel: "9764acbabfaf2714e0b250799f4d4541775419a7bd1785bc397c7cc2f84b0a4a"

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
