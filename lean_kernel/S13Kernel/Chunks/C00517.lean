import S13Kernel.Data.Keys

/-! Keys number 40921 to 40997. `data/c/c00517.txt` has sha256 f0d50e54aeccdf1d3d897ed23cd52be8c708f1f0440111cde22a983191e41f32. -/

namespace S13K.Chunks.C00517

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00517.txt"

theorem chk : chkChunk S N 40921 77 ces = true := by decide +kernel

theorem ok : RangeOK S N 40921 40998 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00517
