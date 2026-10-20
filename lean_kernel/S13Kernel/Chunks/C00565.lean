import S13Kernel.Data.Keys

/-! Keys number 45539 to 45641. `data/c/c00565.txt` has sha256 431d9bb5b75f11c420ba1e8162aeb03680f77dbc2b5fe7c75a57c681cf5794aa. -/

namespace S13K.Chunks.C00565

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00565.txt"

theorem chk : chkChunk S N 45539 103 ces = true := by decide +kernel

theorem ok : RangeOK S N 45539 45642 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00565
