# bigtext and bigtext-cli from the release binaries, for macOS and Linux. Homebrew does not
# quarantine a formula's downloads, so macOS opens them without the unsigned-app warning. The
# tap's update workflow keeps `version` and the checksums at the latest release.
class Bigtext < Formula
  desc "Text editor for huge files that never loads them into memory"
  homepage "https://erkinbek.github.io/bigtext/"
  version "0.14.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Erkinbek/bigtext/releases/download/v#{version}/bigtext-macos-arm64.tar.gz"
      sha256 "f87face389200a061a25de155e5e93faa95bc0e71360db98ce386f206b9f1b4b"
    end
    on_intel do
      url "https://github.com/Erkinbek/bigtext/releases/download/v#{version}/bigtext-macos-x64.tar.gz"
      sha256 "e5ba036a03600d79161956a7c71d38b61c5c6906a5b748f3a17d737580358105"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Erkinbek/bigtext/releases/download/v#{version}/bigtext-linux-x64.tar.gz"
      sha256 "089792cfb5f1c88e5930a96c88cfdde5ba8540fe3bceff6abfa00e6ebdc522ba"
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
