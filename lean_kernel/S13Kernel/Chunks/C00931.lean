import S13Kernel.Data.Keys

/-! Keys number 80848 to 80950. `data/c/c00931.txt` has sha256 d7f37efeb2880d9b38cdc0667d3a079188f1583d03bcb117d7860c1a970894df. -/

namespace S13K.Chunks.C00931

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00931.txt"

theorem chk : chkChunk S N 80848 103 ces = true := by decide +kernel

theorem ok : RangeOK S N 80848 80951 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00931
