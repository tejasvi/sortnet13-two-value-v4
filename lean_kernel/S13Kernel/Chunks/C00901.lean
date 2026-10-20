import S13Kernel.Data.Keys

/-! Keys number 77779 to 77896. `data/c/c00901.txt` has sha256 aea534f647efb6aadabd605c5c81672891e564cfb4ad92c84853a6a4e53698a3. -/

namespace S13K.Chunks.C00901

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00901.txt"

theorem chk : chkChunk S N 77779 118 ces = true := by decide +kernel

theorem ok : RangeOK S N 77779 77897 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00901
