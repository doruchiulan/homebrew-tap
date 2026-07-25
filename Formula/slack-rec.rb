class SlackRec < Formula
  desc "Record a Slack call: window video, system audio and microphone"
  homepage "https://github.com/doruchiulan/slack-recorder"
  url "https://github.com/doruchiulan/slack-recorder/releases/download/v0.1.0/slack-rec-0.1.0-universal.tar.gz"
  sha256 "531cc0c09c64b198c09ff37fd1b68531c567ecdf93a80e7059ed4d0ac6a096fa"
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
