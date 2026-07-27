class SlackRec < Formula
  desc "Record a Slack call: window video, system audio and microphone"
  homepage "https://github.com/doruchiulan/slack-recorder"
  url "https://github.com/doruchiulan/slack-recorder/releases/download/v0.2.2/slack-rec-0.2.2-universal.tar.gz"
  sha256 "61f0960dc96398e4cbb1e9d5f36886c9074220b4fb9ef9e6552cc3131ce57696"
  license "MIT"

  # SCStreamConfiguration.captureMicrophone is a Sequoia API with no fallback.
  depends_on macos: :sequoia

  def install
    bin.install "slack-rec"
  end

  def caveats
    <<~EOS
      slack-rec needs two macOS permissions. They are granted to the terminal
      application you run it from, not to the binary:

        System Settings > Privacy & Security > Screen & System Audio Recording
        System Settings > Privacy & Security > Microphone

      Quit and reopen your terminal after granting them, then run:

        slack-rec doctor

      Recordings land in ~/Desktop/CallRec Recordings. ffmpeg is what merges the
      three tracks into a playable call.mp4; without it you still get the tracks,
      but screen.mov has no audio of its own:

        brew install ffmpeg
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/slack-rec --version")
  end
end
