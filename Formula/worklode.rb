class Worklode < Formula
  desc "Work tracker CLI (lode) for Sunstone Institute"
  homepage "https://github.com/sunstoneinstitute/worklode"
  url "https://github.com/sunstoneinstitute/worklode/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "67c695f2397d5f21bbfa31550562f4d80d2c9c8d4c75bb41a96cf420157989dc"
  head "https://github.com/sunstoneinstitute/worklode.git", branch: "main"

  # Bottles are poured by arch; brew falls back to an older-OS bottle of
  # the same arch on newer macOS, and to a source build if none match.
  bottle do
    root_url "https://github.com/sunstoneinstitute/worklode/releases/download/v0.7.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b33d7dca4652549e118fcdd0d115c99a181f94c6d06f1eb48aa01e973b5eec34"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "05d54550506b522dc97793fcc63472d75f5e287eb1c75ce90aa7da124cc11a3a"
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
