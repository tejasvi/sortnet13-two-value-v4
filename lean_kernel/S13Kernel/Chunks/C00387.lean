import S13Kernel.Data.Keys

/-! Keys number 29572 to 29651. `data/c/c00387.txt` has sha256 e889e3f281f3ca1ce325172d44393f7b5e2688a567394ff4f9977a56253f1431. -/

namespace S13K.Chunks.C00387

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00387.txt"

theorem chk : chkChunk S N 29572 80 ces = true := by decide +kernel

theorem ok : RangeOK S N 29572 29652 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00387
