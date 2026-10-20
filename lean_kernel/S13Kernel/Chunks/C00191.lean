import S13Kernel.Data.Keys

/-! Keys number 12792 to 12880. `data/c/c00191.txt` has sha256 08285e9e0747d8acf5c16ab128a3cacf0d2bbf360a596f25c0bfeebdefd076f1. -/

namespace S13K.Chunks.C00191

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00191.txt"

theorem chk : chkChunk S N 12792 89 ces = true := by decide +kernel

theorem ok : RangeOK S N 12792 12881 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00191
