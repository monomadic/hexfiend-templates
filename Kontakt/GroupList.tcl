section "GroupList" {
	# chunk header
	set id [uint16 -hex "id"]
	if {$id != 0x33} {
		error "GroupList must have id 0x33, found $id"
	}
	set length [uint32 "length"]
	set numGroups [uint32 "numGroups"]

	for { set i 0 } { $i < $numGroups } { incr i } {
		section "Group" {
			include "Kontakt/StructuredObjectRaw.tcl"
		}
	}
}
