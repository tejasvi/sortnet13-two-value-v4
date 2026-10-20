import S13Kernel.Data.Keys

/-! Keys number 61330 to 61426. `data/c/c00734.txt` has sha256 489b8cf5260030fd862cefdf596b07a3a4acf907d9fee0e0fabc6c7b46150f19. -/

namespace S13K.Chunks.C00734

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00734.txt"

theorem chk : chkChunk S N 61330 97 ces = true := by decide +kernel

theorem ok : RangeOK S N 61330 61427 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00734
