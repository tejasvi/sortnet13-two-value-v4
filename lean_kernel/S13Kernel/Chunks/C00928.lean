import S13Kernel.Data.Keys

/-! Keys number 80558 to 80650. `data/c/c00928.txt` has sha256 551120c895ceb593718871ad9c2899f86d4a8749bc2ca309d3d40f9642638073. -/

namespace S13K.Chunks.C00928

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00928.txt"

theorem chk : chkChunk S N 80558 93 ces = true := by decide +kernel

theorem ok : RangeOK S N 80558 80651 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00928
