class Layover < Formula
  desc "Run a lights-out agent factory: supervise headless agent CLIs, route messages between them, and keep them bounded."
  homepage "https://kotkaz.github.io/layover-project/"
  version "0.23.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/KotkaZ/layover-project/releases/download/v0.23.0/layover-cli-aarch64-apple-darwin.tar.xz"
      sha256 "f51d141b978cfbab4e8b42e5052ec2ab6259fafc97e61ceeb23ede1abb623736"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KotkaZ/layover-project/releases/download/v0.23.0/layover-cli-x86_64-apple-darwin.tar.xz"
      sha256 "c700f16d89ff5fb3469aa29cb744393b5a62c2d24856921efbb0de7c291ec7f3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/KotkaZ/layover-project/releases/download/v0.23.0/layover-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "17fcf67ec89fc9738becbf5dff059ecf9cc4bf0da98cc2e2d3885b8f37b9122d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KotkaZ/layover-project/releases/download/v0.23.0/layover-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d7b0bfd861892eabb05f54ed10be48e857045993975e57cf0f4a5ec268ca38eb"
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
