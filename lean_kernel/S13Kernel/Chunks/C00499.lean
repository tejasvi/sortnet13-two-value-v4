import S13Kernel.Data.Keys

/-! Keys number 39366 to 39453. `data/c/c00499.txt` has sha256 ae29dbe60e697ac9f0137a215705077706da7179edca225a01809c1e3cdbd140. -/

namespace S13K.Chunks.C00499

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00499.txt"

theorem chk : chkChunk S N 39366 88 ces = true := by decide +kernel

theorem ok : RangeOK S N 39366 39454 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00499
