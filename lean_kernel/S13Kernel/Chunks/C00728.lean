import S13Kernel.Data.Keys

/-! Keys number 60764 to 60859. `data/c/c00728.txt` has sha256 f92ed997679a3488333c94e0be4fd99284d1baa4f00a60db6398244bcc71b835. -/

namespace S13K.Chunks.C00728

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00728.txt"

theorem chk : chkChunk S N 60764 96 ces = true := by decide +kernel

theorem ok : RangeOK S N 60764 60860 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00728
