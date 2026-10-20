import S13Kernel.Data.Keys

/-! Keys number 73867 to 73963. `data/c/c00864.txt` has sha256 ba459659d8760bf3504c5103b323f646183108b9b6019d65adff7cfc71dd0de5. -/

namespace S13K.Chunks.C00864

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00864.txt"

theorem chk : chkChunk S N 73867 97 ces = true := by decide +kernel

theorem ok : RangeOK S N 73867 73964 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00864
