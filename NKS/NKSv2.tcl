# 160 bytes
section "BPatchHeaderV2" {
	set headerMagic [hex 4 "headerMagic"]
	if {$headerMagic != 0x722A013E && $headerMagic != 0xB36EE55E} {
		error "NKS headerMagic must be 0x722A013E, found $headerMagic"
	}

	uint16 "?"

	uint8 "patchVersionMinorC"
	uint8 "patchVersionMinorB"
	uint8 "patchVersionMinorA"
	uint8 "patchVersionMajor"

	ascii 4 "appSignature"

	unixtime32 "creationDate"

	uint32 "?"

	uint16 "numZones"
	uint16 "numGroups"
	uint16 "numInstruments"

	uint16 "u16?"
	uint16 "u16?"
	set patchType [uint32 "patchType"]
	uint8 "u8?"
	uint16 "u16?"
	uint32 "u32?"
	uint8 "u8?"

	uint32 "icon"

	ascii 8 "author"
	uint8 "?"
	uint16 "?"
	ascii 86 "url"
	ascii 7 "?"

	uint32	"svnRev"
	uint32 "patchLevel"
}

if {$patchType == 1} {
	section "resourceRoot" {
		include "NKS/ResourceBlock.tcl"
	}
} else {
	bytes eof "compressedData"
}
