import S13Kernel.Data.Keys

/-! Keys number 10609 to 10687. `data/c/c00160.txt` has sha256 1345594adbf616c4a9264e860e47254e60f6c5baf31cebeb8367d289b040c049. -/

namespace S13K.Chunks.C00160

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00160.txt"

theorem chk : chkChunk S N 10609 79 ces = true := by decide +kernel

theorem ok : RangeOK S N 10609 10688 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00160
