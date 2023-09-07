ascii 16 "magic"
bytes 248 "padding"
ascii 8 "MARKER_END"

set numFiles [uint64 "numFiles"]
set length [uint64 "dataSectionLength"]

ascii 16 "magic"
bytes 600

section "files" {
	for { set i 0 } { $i < $numFiles } { incr i } {
		section "file" {
			uint64 "fileIndex"
			bytes 16
			ascii 600 "fileName"
			uint64 "?"
			uint64 "fileSize"
		}
	}
}

ascii 8 "MARKER_END"
bytes 16


ascii 16 "magic"
bytes 592

bytes eof "filedata"
