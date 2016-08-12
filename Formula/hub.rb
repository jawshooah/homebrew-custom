class Hub < Formula
  desc "Hub with PR templates"
  homepage "https://hub.github.com/"
  url "https://github.com/jawshooah/hub.git", using: :git, revision: "d53d4b8e90e38d8d46a8c0fc96469580296bd16f"
  version "2.2.4-13-gd53d4b8"

  option "without-completions", "Disable bash/zsh completions"

  depends_on "go" => :build

  def install
    system "script/build", "-o", "hub"
    bin.install "hub"
    man1.install Dir["man/*"]

    if build.with? "completions"
      bash_completion.install "etc/hub.bash_completion.sh"
      zsh_completion.install "etc/hub.zsh_completion" => "_hub"
    end
  end

  test do
    system "git", "init"
    %w[haunted house].each { |f| touch testpath/f }
    system "git", "add", "haunted", "house"
    system "git", "commit", "-a", "-m", "Initial Commit"
    assert_equal "haunted\nhouse", shell_output("#{bin}/hub ls-files").strip
  end
end
