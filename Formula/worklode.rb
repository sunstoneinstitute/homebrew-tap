class Worklode < Formula
  desc "Work tracker CLI (lode) for Sunstone Institute"
  homepage "https://github.com/sunstoneinstitute/worklode"
  url "https://github.com/sunstoneinstitute/worklode/archive/refs/tags/v0.8.0.tar.gz"
  sha256 "0203445a55ac003440672ea0d9d61cc626fc93840f0a2840c510640284b3b30d"
  head "https://github.com/sunstoneinstitute/worklode.git", branch: "main"

  # Bottles are poured by arch; brew falls back to an older-OS bottle of
  # the same arch on newer macOS, and to a source build if none match.
  bottle do
    root_url "https://github.com/sunstoneinstitute/worklode/releases/download/v0.8.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "511743c2882ae8ac8a729ca202f5a06512d4d7eb55b98ca53f9ee6d004d9ec6d"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "9ec13b2fd7076ad5780e27770d31cd5e4f07fcf36d1271bce362d4bdb1e76850"
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
