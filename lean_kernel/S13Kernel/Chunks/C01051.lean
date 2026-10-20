import S13Kernel.Data.Keys

/-! Keys number 93711 to 93823. `data/c/c01051.txt` has sha256 6c4d49936f4e06a4b1786c78306a6af987ebbec03f5521805a05b8a958873933. -/

namespace S13K.Chunks.C01051

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01051.txt"

theorem chk : chkChunk S N 93711 113 ces = true := by decide +kernel

theorem ok : RangeOK S N 93711 93824 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01051
