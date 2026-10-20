import S13Kernel.Data.Keys

/-! Keys number 35837 to 35939. `data/c/c00461.txt` has sha256 d02ce6de3eaf452479e7c7da4ead5f166b7ad0b75c5f113124c0c446acf3e340. -/

namespace S13K.Chunks.C00461

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00461.txt"

theorem chk : chkChunk S N 35837 103 ces = true := by decide +kernel

theorem ok : RangeOK S N 35837 35940 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00461
