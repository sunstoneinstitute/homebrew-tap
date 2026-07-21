class Horndb < Formula
  desc "Hybrid RDF reasoner (OWL 2 RL) with a SPARQL 1.1 HTTP frontend"
  homepage "https://github.com/sunstoneinstitute/horndb"
  url "https://github.com/sunstoneinstitute/horndb/releases/download/v0.5.0/horndb-0.5.0.tar.gz"
  sha256 "765cee8162af0aa25a3c7d98047f014f0d0ea2fb6f781a5e38e8550836d760f7"
  license "Apache-2.0"

  # Bottles are poured by arch; brew falls back to an older-OS bottle of
  # the same arch on newer macOS, and to a source build if none match.
  bottle do
    root_url "https://github.com/sunstoneinstitute/horndb/releases/download/v0.5.0"
    sha256 cellar: :any, arm64_sonoma: "84d3180b3efa056fe667b4fc5e952013159d4525ff3918f7337b8975cd91927e"
    sha256 cellar: :any, arm64_tahoe:  "146d9d639dbc85e2fe672e6b892276e977c9af80dafc711f4f67e42b33dd863e"
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
