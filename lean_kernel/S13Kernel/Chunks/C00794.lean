import S13Kernel.Data.Keys

/-! Keys number 67069 to 67154. `data/c/c00794.txt` has sha256 aec075b4bfea20f6ea360f14ce9ae548251b59632f18be0b7d20050b7f6ba628. -/

namespace S13K.Chunks.C00794

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00794.txt"

theorem chk : chkChunk S N 67069 86 ces = true := by decide +kernel

theorem ok : RangeOK S N 67069 67155 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00794
