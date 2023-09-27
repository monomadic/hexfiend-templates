set magic [hex 4 "magic"]

switch $magic {
	0xAB85EF01 {
		big_endian
	}
}

switch $magic {
	0x5EE56EB3 {
		include "NKS/BPatchHeaderV1.tcl"
		bytes eof "zlibCompressedData"
	}

	default	{
		# note: this is decompressed length in v2
		set zlibLength [uint32 "zlibLength"]
		set headerVersion [uint16 "headerVersion"]

		if {$headerVersion < 256} {
			include "NKS/BPatchHeaderV1.tcl"
			bytes eof "zlibCompressedData"
		}

		if {$headerVersion > 0xFF && $headerVersion <= 0x10F} {
			include "NKS/BPatchHeaderV2.tcl"
			bytes eof "zlibCompressedData"
		}

		if {$headerVersion > 0x10F} {
			# include "NKS/BPatchHeaderV42.tcl"
			# bytes eof "zlibCompressedData"
		}
	}
}
