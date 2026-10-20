import S13Kernel.Data.Keys

/-! Keys number 13844 to 13930. `data/c/c00203.txt` has sha256 56ff414551ea1e682c117fe1dc5e0a4846c39a21aada583b9f17ff874f6abad3. -/

namespace S13K.Chunks.C00203

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00203.txt"

theorem chk : chkChunk S N 13844 87 ces = true := by decide +kernel

theorem ok : RangeOK S N 13844 13931 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00203
