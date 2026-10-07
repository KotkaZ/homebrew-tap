class Layover < Formula
  desc "Supervise headless agent CLIs, route their messages, and bound what they spend."
  homepage "https://kotkaz.github.io/layover-project/"
  version "1.8.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/KotkaZ/layover-project/releases/download/v1.8.0/layover-cli-aarch64-apple-darwin.tar.xz"
      sha256 "09ee52ded9f66a4c6ce8644423298d333a37371b491082a78bdee7415cae51cb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KotkaZ/layover-project/releases/download/v1.8.0/layover-cli-x86_64-apple-darwin.tar.xz"
      sha256 "e7430b24c2f42fb9b701740a506560b3c243b1ae0aef3f1f244b7d58b2a2ae7b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/KotkaZ/layover-project/releases/download/v1.8.0/layover-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ab04d206280a151a8733fb5187698b8ea1fbf39ae7d644230c09db4115776890"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KotkaZ/layover-project/releases/download/v1.8.0/layover-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a0dcb5d2f252e30a522dfca080852e4e97533b37fa9f045baad0a4370ba2b747"
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
