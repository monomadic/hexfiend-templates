# 160 bytes
section "BPatchHeaderV2" {
	set headerMagic [hex 4 "headerMagic"]
	# if {$headerMagic != 0x1A6337EA} {
	# 	error "NKS headerMagic must be 0x1290A87F, found $headerMagic"
	# }

	set patchType [uint16 "patchType"]

	uint8 "patchVersionMinorC"
	uint8 "patchVersionMinorB"
	uint8 "patchVersionMinorA"
	uint8 "patchVersionMajor"

	ascii 4 "appSignature"

	unixtime32 "creationDate"

	uint32 "u_a"

	uint16 "numZones"
	uint16 "numGroups"
	uint16 "numInstruments"

	uint32 "pcmDataLen"
	set isMonolith [uint32 "isMonolith"]

	uint8 "supportVersionMinorC"
	uint8 "supportVersionMinorB"
	uint8 "supportVersionMinorA"
	uint8 "supportVersionMajor"

	uint32 "u_c"

	uint32 "catIconIdx"
	ascii 8 "instrumentAuthor"
	uint8 "instrumentCat1"
	uint8 "instrumentCat1"
	uint8 "instrumentCat1"
	ascii 85 "instrumentURL"

	uint32 "u_b"

	uint32 "patchLevel"
	uint32 "svnRev"
	uint32 "soundInfoOffset"
}

if {$isMonolith == 1} {
	section "resourceRoot" {
		include "NKS/ResourceBlock.tcl"
	}
} else {
	bytes eof "compressedData"
}
