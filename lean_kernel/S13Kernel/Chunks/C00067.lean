import S13Kernel.Data.Keys

/-! Keys number 3771 to 3851. `data/c/c00067.txt` has sha256 ff177e4c7d7028554ae91b10d5a76d493fbea6eaf38786e6c33ebb6de2960fbf. -/

namespace S13K.Chunks.C00067

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00067.txt"

theorem chk : chkChunk S N 3771 81 ces = true := by decide +kernel

theorem ok : RangeOK S N 3771 3852 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00067
