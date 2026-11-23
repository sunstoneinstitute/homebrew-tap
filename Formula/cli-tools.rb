class CliTools < Formula
  desc "Sunstone Institute command-line tools"
  homepage "https://github.com/sunstoneinstitute/cli-tools"
  url "https://github.com/sunstoneinstitute/cli-tools/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "ee29b6a09a63dbdf6476a028945d47337457e364c2a2017e99f22fd681b2c382"
  head "https://github.com/sunstoneinstitute/cli-tools.git", branch: "main"

  # Bottles are poured by arch; brew falls back to an older-OS bottle of
  # the same arch on newer macOS, and to a source build if none match.
  bottle do
    root_url "https://github.com/sunstoneinstitute/cli-tools/releases/download/v0.1.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e6d679e42ce2673b5a0c2cd7a84fea4ebef8952dfb2046361c0d7682198459fe"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "14aabc1957a48799cf10b07277e96b5a42b0a764e78612a0c17bb2eadac804ee"
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
