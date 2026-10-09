# Homebrew formula for cadrei, filled in from a release by formula.sh. It
# installs the release binary for the machine (no build, no bottles). The
# release step copies it into the rafi-ramdhani/homebrew-cadrei tap.
class Cadrei < Formula
  desc "Plug-and-play orchestration for Claude Code"
  homepage "https://github.com/rafi-ramdhani/cadrei"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/rafi-ramdhani/cadrei/releases/download/v0.2.0/cadrei_0.2.0_darwin_arm64.tar.gz"
      sha256 "54572b5f6e9caa83a96c4fa69f083e06469f2c187bbf59265e0eae4163e38cb1"
    end
    on_intel do
      url "https://github.com/rafi-ramdhani/cadrei/releases/download/v0.2.0/cadrei_0.2.0_darwin_amd64.tar.gz"
      sha256 "40e0d98054a1a19edebe2cdee96be304268b1f371dce3f79aca225a0ee6fc127"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rafi-ramdhani/cadrei/releases/download/v0.2.0/cadrei_0.2.0_linux_arm64.tar.gz"
      sha256 "f8d3f515b859cb077d25c237cf0de8757df8c7fbe91b9445f33d60c9e0dc7780"
    end
    on_intel do
      url "https://github.com/rafi-ramdhani/cadrei/releases/download/v0.2.0/cadrei_0.2.0_linux_amd64.tar.gz"
      sha256 "f6051603e59f25bd37749cd8cf5943ac983bff5dea148a191c9dc973fe72a2f3"
    end
    depends_on "git"
  end

  depends_on "tmux"

  def install
    bin.install "cadrei"
  end

  def caveats
    <<~EOS
      cadrei runs Claude Code, which a formula cannot depend on. Install it with:
        brew install --cask claude-code
      Then run: cadrei
      To remove cadrei later: cadrei uninstall, then brew uninstall cadrei
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cadrei --version")
    ENV["HOME"] = testpath
    system bin/"cadrei", "init", "demo"
    assert_path_exists testpath/".cadrei/demo/playbook.md"
  end
end
