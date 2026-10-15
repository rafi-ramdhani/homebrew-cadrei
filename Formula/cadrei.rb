# Homebrew formula for cadrei, filled in from a release by formula.sh. It
# installs the release binary for the machine (no build, no bottles). The
# release step copies it into the rafi-ramdhani/homebrew-cadrei tap.
class Cadrei < Formula
  desc "Team of Claude Code helpers you lead from one chat"
  homepage "https://cadrei.dev"
  # Some Homebrew versions read "64" from these URLs, so say it.
  version "0.2.2"
  license all_of: ["MIT", :cannot_represent]

  depends_on "tmux"

  on_macos do
    on_arm do
      url "https://github.com/rafi-ramdhani/cadrei/releases/download/v0.2.2/cadrei_0.2.2_darwin_arm64.tar.gz"
      sha256 "84866bf58a091e7f79b546cc1c5f7f66a8c845957fa173a13769d6efe32d6cdb"
    end
    on_intel do
      url "https://github.com/rafi-ramdhani/cadrei/releases/download/v0.2.2/cadrei_0.2.2_darwin_amd64.tar.gz"
      sha256 "b6ca95445c5c776243ad54607e474e6b11e32e3c1754b5d5144bdf5c3cbb2dd1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rafi-ramdhani/cadrei/releases/download/v0.2.2/cadrei_0.2.2_linux_arm64.tar.gz"
      sha256 "d6ac621a0e0a0097959ba6926f213519e811717deac1b9f310f51bbcc55ddaaa"
    end
    on_intel do
      url "https://github.com/rafi-ramdhani/cadrei/releases/download/v0.2.2/cadrei_0.2.2_linux_amd64.tar.gz"
      sha256 "3f0a6db22de21e008af8c96eda72504aceb6b5921b41792ba912d51ea450450b"
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
