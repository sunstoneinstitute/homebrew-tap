class Worklode < Formula
  desc "Work tracker CLI (lode) for Sunstone Institute"
  homepage "https://github.com/sunstoneinstitute/worklode"
  url "https://github.com/sunstoneinstitute/worklode/archive/refs/tags/v0.15.0.tar.gz"
  sha256 "ba371bf4b120395bad5b49f7edcfc7e637b58f780e681f322796edd071a5d0e6"
  head "https://github.com/sunstoneinstitute/worklode.git", branch: "main"

  # Bottles are poured by arch; brew falls back to an older-OS bottle of
  # the same arch on newer macOS, and to a source build if none match.
  bottle do
    root_url "https://github.com/sunstoneinstitute/worklode/releases/download/v0.15.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "47075c137ed9f3a025e098d841616fcf2ca6cf623d1dfc3e87a310348fa1e221"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "31c55ffdac370bc4829c21fd29adf749dd538db48033ea6c88c3d2f332873590"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/sunstoneinstitute/worklode/internal/buildinfo.Version=#{version}
    ]
    system "go", "build", *std_go_args(ldflags:, output: bin/"lode"), "./cmd/lode"
    system "go", "build", *std_go_args(ldflags:, output: bin/"lode-hook"), "./cmd/lode-hook"
    system "go", "build", *std_go_args(ldflags:, output: bin/"lode-statusline"), "./cmd/lode-statusline"

    generate_completions_from_executable(bin/"lode", "completion")
  end

  test do
    assert_match "lode version", shell_output("#{bin}/lode --version")
    assert_match version.to_s, shell_output("#{bin}/lode-hook --version")
    assert_match version.to_s, shell_output("#{bin}/lode-statusline --version")
  end
end
