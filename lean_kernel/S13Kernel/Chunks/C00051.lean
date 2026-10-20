import S13Kernel.Data.Keys

/-! Keys number 2676 to 2734. `data/c/c00051.txt` has sha256 86495ff5188ae5467fe158f9b62d5aba7c7d9f2c63795d4a467fbd3acaf8e5a4. -/

namespace S13K.Chunks.C00051

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00051.txt"

theorem chk : chkChunk S N 2676 59 ces = true := by decide +kernel

theorem ok : RangeOK S N 2676 2735 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00051
