set magic [hex 4 "magic"]

switch $magic {
	0x5AE5D6A4 {
		include "NKS/BPatchHeaderV1.tcl"
		bytes eof "zlibCompressedData"
	}
}
