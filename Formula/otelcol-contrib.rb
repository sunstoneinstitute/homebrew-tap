class OtelcolContrib < Formula
  desc "OpenTelemetry Collector (contrib distribution)"
  homepage "https://github.com/open-telemetry/opentelemetry-collector-releases"
  version "0.164.0"
  license "Apache-2.0"

  # Upstream's prebuilt release binary, repackaged. Apple silicon only.
  # Bump the version, url and sha256 together.
  depends_on arch: :arm64
  depends_on :macos

  url "https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/v0.164.0/otelcol-contrib_0.164.0_darwin_arm64.tar.gz"
  sha256 "af6a0c56886e3cc36ccebe849fa167bad2bc47a97a48fd8497a0d6f93d0cf73a"

  def install
    bin.install "otelcol-contrib"
  end

  def post_install
    (var/"lib/otelcol-contrib").mkpath
  end

  # Runs as a per-user LaunchAgent via `brew services start otelcol-contrib`.
  # The config is not shipped here: whoever deploys it (Fleet) writes
  # #{etc}/otelcol-contrib/config.yaml. It can reference the queue directory
  # as ${env:OTELCOL_DATA_DIR}, so it does not depend on the brew prefix.
  service do
    run [opt_bin/"otelcol-contrib", "--config", etc/"otelcol-contrib/config.yaml"]
    environment_variables OTELCOL_DATA_DIR: var/"lib/otelcol-contrib"
    keep_alive true
    log_path var/"log/otelcol-contrib.log"
    error_log_path var/"log/otelcol-contrib.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/otelcol-contrib --version")

    (testpath/"config.yaml").write <<~YAML
      receivers:
        otlp:
          protocols:
            http:
              endpoint: 127.0.0.1:4318
      exporters:
        debug:
      service:
        pipelines:
          traces:
            receivers: [otlp]
            exporters: [debug]
    YAML
    system bin/"otelcol-contrib", "validate", "--config", testpath/"config.yaml"
  end
end
