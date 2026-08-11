class Worklode < Formula
  desc "Work tracker CLI (lode) for Sunstone Institute"
  homepage "https://github.com/sunstoneinstitute/worklode"
  url "https://github.com/sunstoneinstitute/worklode/archive/refs/tags/v0.5.1.tar.gz"
  sha256 "cdf201633a092480b2b364dd63f10b242066cbe42dc2434ccd19366611a0e0ed"
  head "https://github.com/sunstoneinstitute/worklode.git", branch: "main"

  # Bottles are poured by arch; brew falls back to an older-OS bottle of
  # the same arch on newer macOS, and to a source build if none match.
  bottle do
    root_url "https://github.com/sunstoneinstitute/worklode/releases/download/v0.5.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0768c2395c4bdc4f1d2c8f27ac011ff1a12d5e60d21f7c84b80ab93bef76baf2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "359772a6c1badc5b54f1e166d54d14183f04e170d8c4b340a4f685a8ec734be3"
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
