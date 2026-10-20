import S13Kernel.Data.Keys

/-! Keys number 22720 to 22799. `data/c/c00312.txt` has sha256 cf7509e510a57d49ba116afbd31f737128964ca88d98937c076f25dd94034434. -/

namespace S13K.Chunks.C00312

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00312.txt"

theorem chk : chkChunk S N 22720 80 ces = true := by decide +kernel

theorem ok : RangeOK S N 22720 22800 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00312
