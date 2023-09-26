section "BPatchHeaderV1" {
	uint32 "patchOffset"
	uint16 "version"
	uint16 "minorVersion? 1 or 2"
	uint32 "usually 0"
	uint32 "usually 0"
	uint32 "usually 1"
	unixtime32 "timestamp"
	uint32 "samplesSize"
	uint32 "usually 0"
}
