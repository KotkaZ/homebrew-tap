class Layover < Formula
  desc "Supervise headless agent CLIs, route their messages, and bound what they spend."
  homepage "https://kotkaz.github.io/layover-project/"
  version "1.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/KotkaZ/layover-project/releases/download/v1.4.0/layover-cli-aarch64-apple-darwin.tar.xz"
      sha256 "ff1d6752a72f371d1217a49e9339110cac6af13360e8c0e2c5fe029148f86c0b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KotkaZ/layover-project/releases/download/v1.4.0/layover-cli-x86_64-apple-darwin.tar.xz"
      sha256 "f9564dce7db85dc52782c56f96f808effe2313920edafb68f2681e2dc68c7ead"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/KotkaZ/layover-project/releases/download/v1.4.0/layover-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "cb207f16efb3b0294c839396eafbcbe7fb6188cecb6f7b3cc17899e1891b2da5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KotkaZ/layover-project/releases/download/v1.4.0/layover-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c8de2d0f5bba2c2fc945eb27e833492a200b9a37ff067b431380f8f7f5d3c81a"
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
