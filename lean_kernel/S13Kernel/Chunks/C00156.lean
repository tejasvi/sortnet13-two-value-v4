import S13Kernel.Data.Keys

/-! Keys number 10298 to 10366. `data/c/c00156.txt` has sha256 aaa55d3c824db11e7dcad03656a3aa490da1b918129e4fee607295a05e6db827. -/

namespace S13K.Chunks.C00156

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00156.txt"

theorem chk : chkChunk S N 10298 69 ces = true := by decide +kernel

theorem ok : RangeOK S N 10298 10367 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00156
