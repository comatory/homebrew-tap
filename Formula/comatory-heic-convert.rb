class ComatoryHeicConvert < Formula
  desc "Personalized HEIC to JPEG converter"
  homepage "https://github.com/comatory/heic-convert"
  url "https://github.com/comatory/heic-convert/archive/refs/tags/0.1.5.tar.gz"
  sha256 "8b834b08c9fa72bef9c04fef8a405372ffb0783b7bd28bce03a6249659697d1c"
  license "MIT"

  depends_on "go" => :build

  resource "test-heic" do
    url "https://github.com/comatory/heic-convert/raw/refs/tags/0.1.5/cmd/heic-to-jpeg/testdata/sample.heic"
    sha256 "ee5927b410d586f38fcff146ca1f787ce0a1e04f5ab65c7c62ff1afc31c81e2d"
  end

  def install
    system "go", "build", *std_go_args(output: bin/"heic-to-jpeg", ldflags: "-s -w"), "./cmd/heic-to-jpeg"
    man1.install "man/heic-to-jpeg.1"
    pkgshare.install "HEIC to JPG.workflow"
  end

  def caveats
    <<~EOS
      The binary is available as: heic-to-jpeg
      Run `heic-to-jpeg -h` for usage information.

      To install the Automator Quick Action (Finder right-click integration):
        cp -R "#{pkgshare}/HEIC to JPG.workflow" ~/Library/Services/ && open ~/Library/Services/"HEIC to JPG.workflow"
    EOS
  end

  test do
    system bin/"heic-to-jpeg", "-h"

    resource("test-heic").stage do
      system bin/"heic-to-jpeg", "sample.heic"
      assert_path_exists "sample.jpg"
    end
  end
end
