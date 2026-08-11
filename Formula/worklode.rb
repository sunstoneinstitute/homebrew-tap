class Worklode < Formula
  desc "Work tracker CLI (lode) for Sunstone Institute"
  homepage "https://github.com/sunstoneinstitute/worklode"
  url "https://github.com/sunstoneinstitute/worklode/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "b14b61e6b75f3a7ca766134598f09cb5fb4bfa9cc19ccef28d5b07eee76a23ab"
  head "https://github.com/sunstoneinstitute/worklode.git", branch: "main"

  # Bottles are poured by arch; brew falls back to an older-OS bottle of
  # the same arch on newer macOS, and to a source build if none match.
  bottle do
    root_url "https://github.com/sunstoneinstitute/worklode/releases/download/v0.5.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "25effe50b2f83081e3961af67edba0859aea9d12f4fe6778c1f5280a2030eee7"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "0cc702bf183bc73d834a1207c201226c176489941b040d3fdb47dc1e23eda70a"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/sunstoneinstitute/worklode/internal/cmd.version=#{version}
    ]
    system "go", "build", *std_go_args(ldflags:, output: bin/"lode"), "./cmd/lode"

    generate_completions_from_executable(bin/"lode", "completion")
  end

  test do
    assert_match "lode version", shell_output("#{bin}/lode --version")
  end
end
