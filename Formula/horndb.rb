class Horndb < Formula
  desc "Hybrid RDF reasoner (OWL 2 RL) with a SPARQL 1.1 HTTP frontend"
  homepage "https://github.com/sunstoneinstitute/horndb"
  url "https://github.com/sunstoneinstitute/horndb/releases/download/v0.6.0/horndb-0.6.0.tar.gz"
  sha256 "da86119414add9f9442eba24a53e6903c577f7eb0ae852b75f357fa5a0462a7e"
  license "Apache-2.0"

  # Bottles are poured by arch; brew falls back to an older-OS bottle of
  # the same arch on newer macOS, and to a source build if none match.
  bottle do
    root_url "https://github.com/sunstoneinstitute/horndb/releases/download/v0.6.0"
    sha256 cellar: :any, arm64_sequoia: "0bda1e2121878de85d25e42c174078e9049bbe700fab0125fdd3921e928c15c9"
    sha256 cellar: :any, arm64_tahoe:   "a0f7dab90b981aab919033ac83ce5cd51b7f207c1a320ef5243efad5b3a33fdb"
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "rust" => :build
  depends_on "libomp"

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/sparql"),
           "--bin", "serve", "--features", "server"
    mv bin/"serve", bin/"horndb"
  end

  test do
    assert_match "SPARQL", shell_output("#{bin}/horndb --help")
  end
end
