class Anyrec < Formula
  desc "Record any window or display: video, system audio and microphone as separate tracks"
  homepage "https://github.com/doruchiulan/anyrec"
  url "https://github.com/doruchiulan/anyrec/releases/download/v0.1.0/anyrec-0.1.0-universal.tar.gz"
  sha256 "54ebf18ce8fb9d7d446b43518f91c533db4e1f99d61caaf9e9f2b37dcb3fb03a"
  license "MIT"

  # SCStreamConfiguration.captureMicrophone is a Sequoia API with no fallback.
  depends_on macos: :sequoia

  def install
    bin.install "anyrec"
  end

  def caveats
    <<~EOS
      anyrec needs two macOS permissions, granted to the terminal you run it
      from rather than to the binary:

        System Settings > Privacy & Security > Screen & System Audio Recording
        System Settings > Privacy & Security > Microphone

      Quit and reopen your terminal after granting them, then run:

        anyrec doctor

      Recordings land in ~/Desktop/AnyRec Recordings. ffmpeg is what merges the
      three tracks into a playable call.mp4; without it you still get the tracks,
      but screen.mov has no audio of its own:

        brew install ffmpeg
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/anyrec --version")
  end
end
