class Worklode < Formula
  desc "Work tracker CLI (lode) for Sunstone Institute"
  homepage "https://github.com/sunstoneinstitute/worklode"
  url "https://github.com/sunstoneinstitute/worklode/archive/refs/tags/v0.18.0.tar.gz"
  sha256 "299ab285a2c78d0ae2ba3a0297a77e8a0fe55b45191aa27d2dd3256e9d236c93"
  head "https://github.com/sunstoneinstitute/worklode.git", branch: "main"

  # Bottles are poured by arch; brew falls back to an older-OS bottle of
  # the same arch on newer macOS, and to a source build if none match.
  bottle do
    root_url "https://github.com/sunstoneinstitute/worklode/releases/download/v0.18.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "44e6aad80f5ccab67f7935128b774908fe38461d3a8b70b42bfae0e569ac3fb9"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "4dac58fb1033a067d5fd812f254bb513e30a62e12983d7eaf8f600d7964cdba8"
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
