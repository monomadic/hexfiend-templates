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

uint32 "u_a"

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

uint32 "u_c"

uint32 "catIconIdx"
ascii 8 "instrumentAuthor"
uint8 "instrumentCat1"
uint8 "instrumentCat1"
uint8 "instrumentCat1"
ascii 85 "instrumentURL"

uint32 "u_b"

# additional V42 stuff:

uint32 "flags"
bytes 16 "md5_checksum"

uint32 "patchLevel"
uint32 "svnRev"

uint32 "decompressedSize"
bytes 32 "?"
