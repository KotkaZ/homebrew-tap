class Layover < Formula
  desc "Supervise headless agent CLIs, route their messages, and bound what they spend."
  homepage "https://kotkaz.github.io/layover-project/"
  version "1.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/KotkaZ/layover-project/releases/download/v1.2.0/layover-cli-aarch64-apple-darwin.tar.xz"
      sha256 "fe17472a7af561d425fab189ee2a10d672b85a67a9fd33859bb625b2c8320c9b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KotkaZ/layover-project/releases/download/v1.2.0/layover-cli-x86_64-apple-darwin.tar.xz"
      sha256 "8becc081b113d5d42f520c2f652b403d781d92838803aa8028a6602c81939407"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/KotkaZ/layover-project/releases/download/v1.2.0/layover-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7380aa48c2a67956fa85906cd5e46a6a7f028d9fffb9fb5661fe1bc75c416114"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KotkaZ/layover-project/releases/download/v1.2.0/layover-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2cddaf5acf235d1a63fa1f71253276c979e1bb6a60200a5f0987a83be8c8fef8"
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
