import S13Kernel.Data.Keys

/-! Keys number 10532 to 10608. `data/c/c00159.txt` has sha256 8ecc319a80fcc9168fdbbc1ec2f766c1d3a8beec8b58473211abe6a916c8c82c. -/

namespace S13K.Chunks.C00159

open S13K S13K.Data

set_option Elab.async false
set_option maxRecDepth 100000

load_certs ces from "data/c/c00159.txt"

theorem chk : chkChunk S N 10532 77 ces = true := by decide +kernel

theorem ok : RangeOK S N 10532 10609 := rangeOK_of_chkChunk chk

end S13K.Chunks.C00159
