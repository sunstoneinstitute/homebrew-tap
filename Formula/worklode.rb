class Worklode < Formula
  desc "Work tracker CLI (lode) for Sunstone Institute"
  homepage "https://github.com/sunstoneinstitute/worklode"
  url "https://github.com/sunstoneinstitute/worklode/archive/refs/tags/v0.16.1.tar.gz"
  sha256 "954af73d06e1bf250b2a383a38b671da5028b47fc5e11b83ed508724884c083e"
  head "https://github.com/sunstoneinstitute/worklode.git", branch: "main"

  # Bottles are poured by arch; brew falls back to an older-OS bottle of
  # the same arch on newer macOS, and to a source build if none match.
  bottle do
    root_url "https://github.com/sunstoneinstitute/worklode/releases/download/v0.16.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e5c05d638f4c65daf9e90f9cbb759fa06d8d398aa8d9637601e2884a8be3d867"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "b32b7db63e912c04f9011172bf1f79c116d9010022bc1391ed448b2465272395"
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
