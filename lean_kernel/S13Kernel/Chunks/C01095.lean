import S13Kernel.Data.Keys

/-! Keys number 98850 to 98976. `data/c/c01095.txt` has sha256 fbf2c7cc76570949139c99344a3975c2c47d3cd240f45d0382f6829ddac30e96. -/

namespace S13K.Chunks.C01095

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01095.txt"

theorem chk : chkChunk S N 98850 127 ces = true := by decide +kernel

theorem ok : RangeOK S N 98850 98977 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01095
