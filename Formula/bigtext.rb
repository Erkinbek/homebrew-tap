# bigtext and bigtext-cli from the release binaries, for macOS and Linux. Homebrew does not
# quarantine a formula's downloads, so macOS opens them without the unsigned-app warning. The
# tap's update workflow keeps `version` and the checksums at the latest release.
class Bigtext < Formula
  desc "Text editor for huge files that never freezes"
  homepage "https://erkinbek.github.io/bigtext/"
  version "0.7.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Erkinbek/bigtext/releases/download/v#{version}/bigtext-macos-arm64.tar.gz"
      sha256 "651d9f69e9d9ee0224d13620f2a6b4a464686da9fc7996f87e2c108875ae4570"
    end
    on_intel do
      url "https://github.com/Erkinbek/bigtext/releases/download/v#{version}/bigtext-macos-x64.tar.gz"
      sha256 "117094de58c56bd33a7a756e69544e88752e4d3366b955178f12e04e26ec2a42"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Erkinbek/bigtext/releases/download/v#{version}/bigtext-linux-x64.tar.gz"
      sha256 "5dd9f7e591c5380a5e70ff586c6396569925ea97faabc7ef6d7cc0565281cc91"
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
