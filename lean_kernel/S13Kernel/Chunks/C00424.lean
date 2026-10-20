import S13Kernel.Data.Keys

/-! Keys number 32868 to 32940. `data/c/c00424.txt` has sha256 35d4a84a21e56a5f5b08704c8d71278f70dad3a6940d25140ea89d3030266d0a. -/

namespace S13K.Chunks.C00424

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00424.txt"

theorem chk : chkChunk S N 32868 73 ces = true := by decide +kernel

theorem ok : RangeOK S N 32868 32941 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00424
