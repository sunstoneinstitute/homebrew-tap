class Worklode < Formula
  desc "Work tracker CLI (lode) for Sunstone Institute"
  homepage "https://github.com/sunstoneinstitute/worklode"
  url "https://github.com/sunstoneinstitute/worklode/archive/refs/tags/v0.6.1.tar.gz"
  sha256 "85424310606d67d6e83ad9243ef98eefbb907ec5ebf0ae5d335343fea73f1b8b"
  head "https://github.com/sunstoneinstitute/worklode.git", branch: "main"

  # Bottles are poured by arch; brew falls back to an older-OS bottle of
  # the same arch on newer macOS, and to a source build if none match.
  bottle do
    root_url "https://github.com/sunstoneinstitute/worklode/releases/download/v0.6.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ac98c2a7d7f8cd37bf09433279afbf7d3cbf5d90749fb5e83016aeb9d8b084c1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "c6f177696963a8a50a1bee6f321dc3fd348913b6c696a1639716b2f1cd47c9b3"
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
