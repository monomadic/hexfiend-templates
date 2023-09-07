hex 4 "magic 0x54AC705E"

section "DirectoryHeader" {
	set version [hex 2 "version"]
	uint32 "set_id"
	uint32 "?"
	uint32 "entryCount"
	uint32 "?"

	switch $version {
		0x0100 {}
		0x0110 {}
		0x1101 {
			uint16 "?"
			uint32 "offset"
			uint16 "type"
		}
	}
}
