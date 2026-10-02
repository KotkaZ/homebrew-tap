class Layover < Formula
  desc "Supervise headless agent CLIs, route their messages, and bound what they spend."
  homepage "https://kotkaz.github.io/layover-project/"
  version "1.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/KotkaZ/layover-project/releases/download/v1.6.0/layover-cli-aarch64-apple-darwin.tar.xz"
      sha256 "b7fb0d300d036db8169d1c106adf52bc775f3dce1067d684183b43c616be39b1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KotkaZ/layover-project/releases/download/v1.6.0/layover-cli-x86_64-apple-darwin.tar.xz"
      sha256 "7e4df8bb904651c56fbdfab33a65595190061c19e47de12a9fd01ce13fbf9237"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/KotkaZ/layover-project/releases/download/v1.6.0/layover-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9f65203773bf766e9d2ff579a02b3a42eca2aa8a57b695950387677da0ddf743"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KotkaZ/layover-project/releases/download/v1.6.0/layover-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "168bfbfad3d30633aaa853c8519a89cf08119612f05a8bc9d8301c9d6a3444c4"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "layover"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "layover"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "layover"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "layover"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
