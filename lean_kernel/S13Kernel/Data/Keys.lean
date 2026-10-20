import S13Kernel.Load

/-! The keys of the certificate (untrusted data). `data/keys.txt` has sha256 1302e09be5298e2948a64d4289de719acfe064213bdc70f1285c70b05229297c. -/

namespace S13K.Data

load_keys S from "data/keys.txt"

/-- The number of keys. -/
def N : Nat := 99736

end S13K.Data
