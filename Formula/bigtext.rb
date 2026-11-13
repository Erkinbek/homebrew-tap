# bigtext and bigtext-cli from the release binaries, for macOS and Linux. Homebrew does not
# quarantine a formula's downloads, so macOS opens them without the unsigned-app warning. The
# tap's update workflow keeps `version` and the checksums at the latest release.
class Bigtext < Formula
  desc "Text editor for huge files that never freezes"
  homepage "https://erkinbek.github.io/bigtext/"
  version "0.10.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Erkinbek/bigtext/releases/download/v#{version}/bigtext-macos-arm64.tar.gz"
      sha256 "9b84e91031767ba9237829b883d0fc3082cd237a40e7f0a6d3e599fb1d99320e"
    end
    on_intel do
      url "https://github.com/Erkinbek/bigtext/releases/download/v#{version}/bigtext-macos-x64.tar.gz"
      sha256 "ab230fa889989be0aeef8beea046fe04a5a2cd399a742939750ced5f812df2da"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Erkinbek/bigtext/releases/download/v#{version}/bigtext-linux-x64.tar.gz"
      sha256 "f0995c4be724af95e3a3e520519c38308c357ba29644307d5718cb802b6de13e"
    end
  end

  livecheck do
    url :stable
    strategy :github_latest
  end

  def install
    bin.install "bigtext", "bigtext-cli"
    doc.install "README.md", "FEATURES.md", "USAGE.md"
  end

  test do
    (testpath/"app.log").write "2024-05-01 10:00:00 INFO a\n2024-05-01 10:00:01 ERROR b\n"
    assert_equal "1", shell_output("#{bin}/bigtext-cli count ERROR #{testpath}/app.log").strip
  end
end
