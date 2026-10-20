import S13Kernel.Data.Keys

/-! Keys number 42414 to 42506. `data/c/c00533.txt` has sha256 95ed9b8883d6d1060802be2adf72ee3d6008ea7ef83db0e92100012c221c7cbc. -/

namespace S13K.Chunks.C00533

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00533.txt"

theorem chk : chkChunk S N 42414 93 ces = true := by decide +kernel

theorem ok : RangeOK S N 42414 42507 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00533
