import json
import wave
import ffmpeg
import numpy as np
from io import BytesIO
from pathlib import Path
from vosk import Model, KaldiRecognizer

class SpeechToTextEngine:
    def normalize_audio(self, audio):
        out, err = ffmpeg.input('pipe:0') \
            .output('pipe:1', f='WAV', acodec='pcm_s16le', ac=1, ar='16k', loglevel='error', hide_banner=None) \
            .run(input=audio, capture_stdout=True, capture_stderr=True)
        if err:
            raise Exception(err)
        return out

    def setLang(self, lang_key):
        model_path = Path(__file__).parents[1].joinpath('models').joinpath(lang_key).absolute().as_posix()
        self.model = Model(model_path)

    def run(self, audio):
        fp = BytesIO(self.normalize_audio(audio))

        kaldi = KaldiRecognizer(self.model, 16000)
        buf = bytearray(8192)
        im_ok = False
        while fp.readinto(buf):
            kaldi.AcceptWaveform(buf)
            im_ok = True

        return json.loads(kaldi.FinalResult())['text'] if im_ok else ''
