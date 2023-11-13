# 222 bytes

hex 4 "magic"

set patchType [uint16 "patchType"]

section "patchVersion" {
	uint8 "patch_level"
	uint8 "minor_b"
	uint8 "minor_a"
	uint8 "major"
}

ascii 4 "appSignature"

unixtime32 "creationDate"

uint32 "u_a_u32?"

uint16 "numZones"
uint16 "numGroups"
uint16 "numInstruments"

uint32 "pcmDataLen"

set isMonolith [uint32 "isMonolith"]

section "minVersion" {
	uint8 "patch_level"
	uint8 "minor_b"
	uint8 "minor_a"
	uint8 "major"
}

uint32 "decompressedLen?"

uint32 "icon"

ascii 8 "author"
uint8 "?"
uint16 "?"
ascii 86 "url"
ascii 7 "?"

# additional V42 stuff:

bytes 16 "md5_checksum"

uint32 "svnRev"
uint32	"crc32_fast"
uint32 "decompressedSize"

bytes 32 "?"

#set numStrings [uint32 "numStrings"]
