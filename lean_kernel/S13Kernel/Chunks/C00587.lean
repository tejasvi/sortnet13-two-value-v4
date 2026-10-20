import S13Kernel.Data.Keys

/-! Keys number 47590 to 47676. `data/c/c00587.txt` has sha256 b8bcb9f536960f31bdda267d01840bb20188ae31848810809d3d81dae49a7d07. -/

namespace S13K.Chunks.C00587

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00587.txt"

theorem chk : chkChunk S N 47590 87 ces = true := by decide +kernel

theorem ok : RangeOK S N 47590 47677 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00587
