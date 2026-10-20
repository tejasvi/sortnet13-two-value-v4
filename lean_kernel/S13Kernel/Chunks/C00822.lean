import S13Kernel.Data.Keys

/-! Keys number 69836 to 69945. `data/c/c00822.txt` has sha256 59a4fa55e2df613225c5457631925489114d356ac0d740cfff0fabd8f4d97b24. -/

namespace S13K.Chunks.C00822

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00822.txt"

theorem chk : chkChunk S N 69836 110 ces = true := by decide +kernel

theorem ok : RangeOK S N 69836 69946 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00822
