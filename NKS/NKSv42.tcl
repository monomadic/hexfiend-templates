# 222 bytes
section "BPatchHeaderV42" {
	set headerMagic [hex 4 "headerMagic"]
	if {$headerMagic != 0x1A6337EA} {
		error "NKS headerMagic must be 0x1290A87F, found $headerMagic"
	}

	set patchType [uint16 "patchType"]

	uint8 "patchVersionMinorC"
	uint8 "patchVersionMinorB"
	uint8 "patchVersionMinorA"
	uint8 "patchVersionMajor"

	ascii 4 "appSignature"

	unixtime32 "creationDate"

	uint32 "creationDatePadding"

	uint16 "numZones"
	uint16 "numGroups"
	uint16 "numInstruments"
	bytes 16 "?"
	uint32 "icon"

	ascii 8 "author"
	ascii 3 "?"
	ascii 86 "url"
	ascii 7 "?"

	bytes 16 "md5_checksum"

	uint32 "?"
	uint32	"svnRev"
	uint32 "decompressedSize"

	bytes 32 "?"

	#set numStrings [uint32 "numStrings"]
}

bytes $zlibLength "compressedSegment"

section "footer" {
	hex 4 "footerMagic"
	uint8 ""
	uint8 ""
	uint16 ""
	set length [uint32 "length"]
	bytes $length "soundInfoItem"
}
