import S13Kernel.Data.Keys

/-! Keys number 67802 to 67890. `data/c/c00802.txt` has sha256 1548f16d99a94ce141c4e40c352ef04bb177c2a0ef4307922d3acd382cbc1aeb. -/

namespace S13K.Chunks.C00802

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00802.txt"

theorem chk : chkChunk S N 67802 89 ces = true := by decide +kernel

theorem ok : RangeOK S N 67802 67891 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00802
