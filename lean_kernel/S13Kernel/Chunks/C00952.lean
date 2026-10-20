import S13Kernel.Data.Keys

/-! Keys number 82940 to 83045. `data/c/c00952.txt` has sha256 9ef102f3f8d631e904dd7c04e3c90608b118673d44a61747fe1b2d4bcd4b9aea. -/

namespace S13K.Chunks.C00952

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00952.txt"

theorem chk : chkChunk S N 82940 106 ces = true := by decide +kernel

theorem ok : RangeOK S N 82940 83046 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00952
