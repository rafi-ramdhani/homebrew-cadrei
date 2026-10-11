# Homebrew formula for cadrei, filled in from a release by formula.sh. It
# installs the release binary for the machine (no build, no bottles). The
# release step copies it into the rafi-ramdhani/homebrew-cadrei tap.
class Cadrei < Formula
  desc "Team of Claude Code helpers you lead from one chat"
  homepage "https://cadrei.dev"
  # Some Homebrew versions read "64" from these URLs, so say it.
  version "0.2.1"
  license all_of: ["MIT", :cannot_represent]

  depends_on "tmux"

  on_macos do
    on_arm do
      url "https://github.com/rafi-ramdhani/cadrei/releases/download/v0.2.1/cadrei_0.2.1_darwin_arm64.tar.gz"
      sha256 "b5374dcdeb9bb352cccfd1766b1ef3e7e0f0327d9fe5ee852d45b302280d6f1f"
    end
    on_intel do
      url "https://github.com/rafi-ramdhani/cadrei/releases/download/v0.2.1/cadrei_0.2.1_darwin_amd64.tar.gz"
      sha256 "7b655f109df7db5094ef23c05c5ce96df78bd19e4f13cbf2ba7815edf4fe64c2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rafi-ramdhani/cadrei/releases/download/v0.2.1/cadrei_0.2.1_linux_arm64.tar.gz"
      sha256 "214602a05be24389a6134f519870e4bd21917f36f9d33023ae80391f50c8514c"
    end
    on_intel do
      url "https://github.com/rafi-ramdhani/cadrei/releases/download/v0.2.1/cadrei_0.2.1_linux_amd64.tar.gz"
      sha256 "886d231ce85ece79d69a743c6a6a36380505edb89ca612c7d96f9153627d8af3"
    end
    depends_on "git"
  end

  def install
    bin.install "cadrei"
  end

  def caveats
    <<~EOS
      cadrei runs Claude Code, which a formula cannot depend on. Install it with:
        brew install --cask claude-code
      Then run: cadrei
      To remove cadrei, run cadrei uninstall: it removes its hooks and links, then the program.
      To try cadrei fresh and keep your setup, run cadrei uninstall --archive --keep-program.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cadrei --version")
    ENV["HOME"] = testpath
    system bin/"cadrei", "new", "demo"
    assert_path_exists testpath/".cadrei/demo/playbook.md"
  end
end
