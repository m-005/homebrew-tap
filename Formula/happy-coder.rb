class HappyCoder < Formula
  desc "Happy CLI tool for productive coding"
  homepage "https://github.com/slopus/happy-cli"
  url "https://registry.npmjs.org/happy-coder/-/happy-coder-0.11.0.tgz"
  sha256 "8dd14cb77be3c31cd54d61dc327a6f8e3b6fb2c2b1bd61fa30fc6c1799968f03"
  license "MIT"

  depends_on "python" => :build
  depends_on "node"

  def install
    # TODO: The @anthropic-ai/claude-code dependency includes a pre-compiled ripgrep.node binary
    # that wasn't built with sufficient header padding (-headerpad_max_install_names).
    # Homebrew's automatic dylib path relinking fails because the Mach-O header can't
    # accommodate the longer /opt/homebrew paths. Since this is a pre-compiled binary
    # we can't rebuild it, and the tool works fine with its original paths, so we
    # want to either Homebrew's linkage checking to avoid the installation
    # failure or some other way to prevent showing a scary error message that
    # does not impact happy-coder's functionality.
    #
    # For now, we'll just skip Homebrew's linkage checking.
    ENV["HOMEBREW_SKIP_LINKAGE_CHECKING"] = "1"

    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    system "#{bin}/happy", "--version"
  end
end
