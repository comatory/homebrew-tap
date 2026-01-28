class ComatoryHeicConvert < Formula
  desc "Personalized HEIC to JPEG converter"
  homepage "https://github.com/comatory/heic-convert"
  url "https://github.com/comatory/heic-convert/archive/refs/tags/0.1.3.tar.gz"
  sha256 "0b7b62525322c23127037eb5a22b24be7204aae75be44aca99cc8d6477c2c6e4"
  license "MIT"

  depends_on "go" => :build

  resource "test-heic" do
    url "https://github.com/comatory/heic-convert/raw/refs/tags/0.1.3/cmd/heic-to-jpeg/testdata/sample.heic"
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
        open "#{pkgshare}/HEIC to JPG.workflow"
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
