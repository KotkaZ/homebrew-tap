class Layover < Formula
  desc "Supervise headless agent CLIs, route their messages, and bound what they spend."
  homepage "https://kotkaz.github.io/layover-project/"
  version "1.11.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/KotkaZ/layover-project/releases/download/v1.11.0/layover-cli-aarch64-apple-darwin.tar.xz"
      sha256 "74d403ad9ccc164900363370a19e5677390d47949656f56fdba0d44ee5e1b8cd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KotkaZ/layover-project/releases/download/v1.11.0/layover-cli-x86_64-apple-darwin.tar.xz"
      sha256 "bb16755918b67e6283c7d7f1dbe7caa289dc29eddf35a116810cdee4ce6904be"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/KotkaZ/layover-project/releases/download/v1.11.0/layover-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7a3d055fd4f2ddfd3f37cf1a3135dcaf89d2ca40c2b0a099792fed44c21d1d2f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/KotkaZ/layover-project/releases/download/v1.11.0/layover-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ca0557a977bd483b5cb9ef7b4200da4841d86e3468c599aced500b8f6061d298"
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
