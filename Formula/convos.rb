class Convos < Formula
  desc "Search & resume your AI coding conversations across every tool"
  homepage "https://github.com/alialfredji/convos"
  url "https://github.com/alialfredji/convos/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "ae45278f4df8058fa201b4262da9db34219b9bfd5870201382d72f7980aa5444"
  license "MIT"
  head "https://github.com/alialfredji/convos.git", branch: "main"

  # bun is only needed to compile the standalone binary, not to run it.
  depends_on "oven-sh/bun/bun" => :build
  depends_on "fzf"

  def install
    # Bundle convos.ts + its local imports and the Bun runtime into one
    # self-contained executable, so the only runtime dependency is fzf.
    system "bun", "build", "convos.ts", "--compile", "--outfile", "convos"
    bin.install "convos"
  end

  test do
    assert_match "search & resume", shell_output("#{bin}/convos --help")
  end
end
