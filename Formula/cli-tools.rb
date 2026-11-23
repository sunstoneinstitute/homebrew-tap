class CliTools < Formula
  desc "Sunstone Institute command-line tools"
  homepage "https://github.com/sunstoneinstitute/cli-tools"
  url "https://github.com/sunstoneinstitute/cli-tools/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "786fc49336341c28d8308b277092129e600f611601ba47c2545e8adacb09f1ad"
  head "https://github.com/sunstoneinstitute/cli-tools.git", branch: "main"

  # Bottles are poured by arch; brew falls back to an older-OS bottle of
  # the same arch on newer macOS, and to a source build if none match.
  bottle do
    root_url "https://github.com/sunstoneinstitute/cli-tools/releases/download/v0.1.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "96a3a183928f0609eb68fa6b7949cc7efacbd84cc841cfc37b63f0e0a91e71f8"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "755ffa24c1c5ddd9c5ebed57b8509d912244fa655d27655d65707458366a7d9d"
  end

  depends_on "go" => :build

  def install
    # Homebrew already sandboxes the build, and SwiftPM cannot nest its own sandbox.
    system "make", "build", "SWIFT_FLAGS=--disable-sandbox"
    bin.install Dir["bin/*"]
  end

  test do
    assert_match "USAGE", shell_output("#{bin}/oidc-browser --help") if OS.mac?
  end
end
