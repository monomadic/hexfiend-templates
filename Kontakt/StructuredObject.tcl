proc chunk {} {
	section "Chunk" {
		set id [hex 1 "id"]
		bytes 1
		set length [uint32 "length"]

		switch $id {
			0x06 {
				sectionname "BParScript"
				object $length
			}
			0x17 {
				sectionname "BParFXSendLevels"
				object $length
			}
			0x25 {
				sectionname "BParFX"
				bytes $length "data"
			}
			0x28 {
				sectionname "BProgram"
				object $length
				#include "Kontakt/BProgram.tcl"
			}
			0x32 {
				sectionname "VoiceGroups"
				bytes $length "data"
				#include "Kontakt/VoiceGroups.tcl"
			}
			0x33 {
				sectionname "GroupList"
				bytes $length "data"
			}
			0x34 {
				sectionname "ZoneList"
				bytes $length "data"
			}
			0x3A {
				sectionname "BParameterArraySer<BParFX,8>"
				object $length
			}
			0x3D {
				sectionname "FNTablePreK51"
				object $length
			}
			0x4B {
				sectionname "FNTableImpl"
				bytes $length "data"
			}
			0x45 {
				sectionname "BInsertBus"
				object $length
			}
			0x47 {
				sectionname "SaveSettings"
				object $length
			}
			0x3B {
				sectionname "FNTableImpl"
				bytes $length "data"
			}
			0x4E {
				sectionname "QuickBrowseData"
				object $length
			}
			default {
				sectionname "Unsupported $id"
				bytes $length "data"
			}
		}
	}
}

proc object { length } {
	set isDataStructured [int8 "isDataStructured"]

	if {$isDataStructured == 1} {
		uint16 -hex "version"

		section "privateData" {
			set privateDataLength [uint32 "privateDataLength"]
			if {$privateDataLength > 0} {
				bytes $privateDataLength "privateData"
			}
		}

		section "publicData" {
			set publicDataLength [uint32 "publicDataLength"]
			bytes $publicDataLength "publicData"
		}

		section "children" {
			set chunkSize [uint32 "length"]
			set maxPos [expr [pos] + $chunkSize]
			while {[pos] < $maxPos} {
				chunk
			}
		}
	} else {
		bytes [expr $length-1] "rawData"
	}
}

while {![end]} { chunk }
