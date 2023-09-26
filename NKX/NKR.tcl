hex 4 "magic 0x54AC705E"

section "DirectoryHeader" {
	set version [uint16 "version"]
	uint32 "set_id"
	uint32 "?"
	set numItems [uint32 "numItems"]
	uint32 "padding"

	for { set i 0 } { $i < $numItems } { incr i } {
		section "BlockItem" {
			set itemLength [uint16 "itemLength"]
			uint32 "offset"
			set referenceType [uint16 "referenceType"]
			utf16 [expr $itemLength - 8] "content"
		}
	}
}
