import S13Kernel.Data.Keys

/-! Keys number 25702 to 25765. `data/c/c00345.txt` has sha256 11400534bbfe96d6c8d35f737d4b0621f27e3ff40100c387b99ea1d053b6aa0f. -/

namespace S13K.Chunks.C00345

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00345.txt"

theorem chk : chkChunk S N 25702 64 ces = true := by decide +kernel

theorem ok : RangeOK S N 25702 25766 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00345
