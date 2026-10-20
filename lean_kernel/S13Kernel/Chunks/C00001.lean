import S13Kernel.Data.Keys

/-! Keys number 32 to 68. `data/c/c00001.txt` has sha256 25c041f91e7a9a5799c158470972468a82276580ae93f825cc2822f0d63f61d1. -/

namespace S13K.Chunks.C00001

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00001.txt"

theorem chk : chkChunk S N 32 37 ces = true := by decide +kernel

theorem ok : RangeOK S N 32 69 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00001
