import S13Kernel.Data.Keys

/-! Keys number 20353 to 20424. `data/c/c00281.txt` has sha256 8998ab25ec9217bc4d9f3e749b3cebfdcc80ba584df1b3b5a3df191d611a2491. -/

namespace S13K.Chunks.C00281

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00281.txt"

theorem chk : chkChunk S N 20353 72 ces = true := by decide +kernel

theorem ok : RangeOK S N 20353 20425 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00281
