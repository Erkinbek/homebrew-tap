# BigText.app for the Applications folder, with bigtext-cli on the PATH. The tap's update
# workflow keeps `version` and the checksums at the latest release.
cask "bigtext-app" do
  arch arm: "arm64", intel: "x64"

  version "0.7.3"
  sha256 arm:   "5e54649da68e1bdeab7af639b9a75d8ab92fe67e5666153828e7ad27d4cd144a",
         intel: "8f963f9f7dd84aa4eeb0485e1ca881422b0b0e802499868d9bd4f08148bff260"

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
