# bigtext and bigtext-cli from the release binaries, for macOS and Linux. Homebrew does not
# quarantine a formula's downloads, so macOS opens them without the unsigned-app warning. The
# tap's update workflow keeps `version` and the checksums at the latest release.
class Bigtext < Formula
  desc "Text editor for huge files that never freezes"
  homepage "https://erkinbek.github.io/bigtext/"
  version "0.11.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Erkinbek/bigtext/releases/download/v#{version}/bigtext-macos-arm64.tar.gz"
      sha256 "feb1d0d1fcc0cfe8a4d61d290bf0317f65fef6e7dfcf637e96019df77c25845e"
    end
    on_intel do
      url "https://github.com/Erkinbek/bigtext/releases/download/v#{version}/bigtext-macos-x64.tar.gz"
      sha256 "7f1a1af9412ae620628860d588f1164c784b36c88198731757ab04bafc0e27d1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Erkinbek/bigtext/releases/download/v#{version}/bigtext-linux-x64.tar.gz"
      sha256 "1722d39042c8b31edb07513aa03976601863567f009c1a11799991d7fe3baeae"
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
