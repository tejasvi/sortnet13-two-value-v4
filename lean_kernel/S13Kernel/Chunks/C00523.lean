import S13Kernel.Data.Keys

/-! Keys number 41443 to 41540. `data/c/c00523.txt` has sha256 895bfdbe29f5fe14d1ddf91689ab98cda4e9cbf19b8392fc34d3149cbcee76c1. -/

namespace S13K.Chunks.C00523

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00523.txt"

theorem chk : chkChunk S N 41443 98 ces = true := by decide +kernel

theorem ok : RangeOK S N 41443 41541 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00523
