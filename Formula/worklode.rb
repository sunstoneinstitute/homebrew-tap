class Worklode < Formula
  desc "Work tracker CLI (lode) for Sunstone Institute"
  homepage "https://github.com/sunstoneinstitute/worklode"
  # url/sha256 are rewritten by the worklode release workflow on each v* tag.
  url "https://github.com/sunstoneinstitute/worklode/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "e6a97175aecbee41587adb305f36102281df7d3eba8388cac73d391c7fca29fd"
  head "https://github.com/sunstoneinstitute/worklode.git", branch: "main"

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
