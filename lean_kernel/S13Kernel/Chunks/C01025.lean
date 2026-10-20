import S13Kernel.Data.Keys

/-! Keys number 90827 to 90931. `data/c/c01025.txt` has sha256 d7d30a7c32151bbfd2ef2ecf2e98ec75545fa305e63d97b961a41d22d6e92498. -/

namespace S13K.Chunks.C01025

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01025.txt"

theorem chk : chkChunk S N 90827 105 ces = true := by decide +kernel

theorem ok : RangeOK S N 90827 90932 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01025
