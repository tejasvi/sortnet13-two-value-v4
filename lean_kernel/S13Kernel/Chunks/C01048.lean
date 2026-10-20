import S13Kernel.Data.Keys

/-! Keys number 93346 to 93468. `data/c/c01048.txt` has sha256 72dee0b4f9362336f84cdf5329ed553efe8f310962bc7d06dfdc7b280d58a39a. -/

namespace S13K.Chunks.C01048

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c01048.txt"

theorem chk : chkChunk S N 93346 123 ces = true := by decide +kernel

theorem ok : RangeOK S N 93346 93469 := rangeOK_of_chkChunk chk

end S13K.Chunks.C01048
