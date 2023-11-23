proc BFileNameSegment {} {
			section "fileSegment" {
				set segmentType [uint8 "segmentType"]

				switch $segmentType {
					1 {
						sectionname "drive"
						set length [uint32 "len"]
						utf16 [expr $length * 2] "name"
					}
					2 {
						sectionname "dir"
						set length [uint32 "len"]
						utf16 [expr $length * 2] "name"
					}
					3 {
						sectionname ".."
					}
					4 {
						sectionname "file"
						set length [uint32 "len"]
						utf16 [expr $length * 2] "name"
					}
					5 {
						set length [uint32 "len"]
						utf16 [expr $length * 2] "name"
					}
					6 {
						sectionname "special"
						# set length [uint32 "len"]
						# utf16 [expr $length * 2] "name"
					}
					8 {
						sectionname "resource?"
						set length [uint32 "len"]
						utf16 [expr $length * 2] "name"
					}

					default {
						exit "unknown segmentType $segmentType"
					}
				}
			}
}

proc FileName {} {
	section "FileName" {
		set segmentCount [uint32 "segmentCount"]
		for { set i 0 } { $i < $segmentCount } { incr i } {
			BFileNameSegment
		}
	}
}

proc FNTablePreK51 {} {
	set id [uint16 -hex "id"]
	if {$id != 0x3d} {
		error "FNTablePreK51 must have id 0x3d, found $id"
	}

	set length [uint32 "length"]
	set specialFileCount [uint32 "specialFileCount"]

	if {$specialFileCount > 0} {
		section "specialFilenameList" {
			for { set i 0 } { $i < $specialFileCount } { incr i } {
				FileName
			}
		}
	}

	set sampleFileCount [uint32 "sampleFileCount"]
	if {$sampleFileCount > 0} {
		section "sampleFilenameList" {
			for { set i 0 } { $i < $sampleFileCount } { incr i } {
				FileName
			}
		}

		section "sampleTimestampTable" {
			for { set i 0 } { $i < $sampleFileCount } { incr i } {
				unixtime32 "creationDate"
				uint32 "?"
			}
		}
	}

	set otherFileCount [uint32 "otherFileCount"]
	if {$otherFileCount > 0} {
		section "otherFileCountList" {
			for { set i 0 } { $i < $otherFileCount } { incr i } {
				# uint32 "?"
				# BFileNameSegment
				# BFileNameSegment
				# BFileNameSegment
				FileName
			}
		}
	}
}

FNTablePreK51
