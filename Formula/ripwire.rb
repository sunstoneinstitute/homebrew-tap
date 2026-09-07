class Ripwire < Formula
  desc "Ranked, deterministic code map for AI coding agents (CLI + MCP server)"
  homepage "https://github.com/redhat-et/ripwire"
  license "Apache-2.0"

  # Upstream ships prebuilt binaries; no source build is attempted here.
  on_macos do
    on_arm do
      url "https://github.com/redhat-et/ripwire/releases/download/v0.4.0/ripwire-0.4.0-macos-arm64.tar.gz"
      sha256 "ee8392f4e48be2076f18558ebae08c51dd90d616988a396e14fcdbc192f7a53d"
    end
    on_intel do
      url "https://github.com/redhat-et/ripwire/releases/download/v0.4.0/ripwire-0.4.0-macos-x64.tar.gz"
      sha256 "34c0b99dcdc3c592d2bc41bb3a34f95338cba5e4fa4fbd0b9579ae0b80bd47e8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/redhat-et/ripwire/releases/download/v0.4.0/ripwire-0.4.0-linux-arm64.tar.gz"
      sha256 "9b82e4d13928974349730b9e713ff71118f5a65967753b03a3ce0b5e352be9c1"
    end
    on_intel do
      url "https://github.com/redhat-et/ripwire/releases/download/v0.4.0/ripwire-0.4.0-linux-x64.tar.gz"
      sha256 "fd0bd0fa849c0e08db59a6a7e5c2d3e9bc062d3089b54196daf9332cd21bbfc8"
    end
  end

  def install
    bin.install "ripwire"
    # Agent skills and hooks are data, not executables: keep them out of PATH.
    pkgshare.install "skills", "hooks"
    doc.install "README.md"
  end

  def caveats
    <<~EOS
      Agent skills and hooks are installed in:
        #{opt_pkgshare}
      Wire ripwire into an agent with:
        ripwire wrap claude
    EOS
  end

  test do
    assert_match "ripwire #{version}", shell_output("#{bin}/ripwire --version")
  end
end
