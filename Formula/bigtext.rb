# bigtext and bigtext-cli from the release binaries, for macOS and Linux. Homebrew does not
# quarantine a formula's downloads, so macOS opens them without the unsigned-app warning. The
# tap's update workflow keeps `version` and the checksums at the latest release.
class Bigtext < Formula
  desc "Text editor for huge files that never freezes"
  homepage "https://erkinbek.github.io/bigtext/"
  version "0.7.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Erkinbek/bigtext/releases/download/v#{version}/bigtext-macos-arm64.tar.gz"
      sha256 "928c20356f4d942cb80e1d6871699beebb493a1c784c7494c767d00c6d40d1d4"
    end
    on_intel do
      url "https://github.com/Erkinbek/bigtext/releases/download/v#{version}/bigtext-macos-x64.tar.gz"
      sha256 "48c3c0cbcfdc779f2bb415731e44dc377511ac06e39b8ec315afe650f9b453fe"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Erkinbek/bigtext/releases/download/v#{version}/bigtext-linux-x64.tar.gz"
      sha256 "42c15e2bb0f18243496aa4322233dcd2d2eecc34d58b9845157da09dfd231c2f"
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
