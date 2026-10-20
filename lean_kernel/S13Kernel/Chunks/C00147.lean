import S13Kernel.Data.Keys

/-! Keys number 9590 to 9675. `data/c/c00147.txt` has sha256 bdd890a671d3002e105d129aefb8f656b4a44366bbe5373bba94b9f6e4289d75. -/

namespace S13K.Chunks.C00147

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00147.txt"

theorem chk : chkChunk S N 9590 86 ces = true := by decide +kernel

theorem ok : RangeOK S N 9590 9676 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00147
