# REX Loop Recycle 1 File Format
#
#	- Chunks are IFF atoms, specifically this is an AIFF file.

big_endian

requires 0 "46 4F 52 4D" ;# FORM / Format
requires 8 "41 49 46 46" ;# AIFF

proc pad2 {size} {
  set padding [expr {$size % 2}]
  if {$padding > 0} {
    entry "zeroPadding" "" $padding
    move $padding
  }
}

proc str {name} {
	set length [uint32]
	if {$length > 0} {
		ascii $length $name
	}
}

proc chunk {} {
	section "Chunk" {
		set magic [ascii 4 "magic"]
		set length [uint32 "length"]

		switch $magic {
			"SSND" {
				sectionname "SSND"
				uint32 "relativeOffset"
				uint32 "absoluteOffset"
				bytes [expr $length - 8] "data"
			}
		}
	}
}

proc category { length } {
	set maxPos [expr [pos] + $length]
	set categoryType [ascii 4 "categoryType"]
	sectionname "Category: $categoryType"
	while {[pos] < $maxPos} {
		chunk
	}
}

set magic [ascii 4 "chunkID"]
set fileLength [uint32 "fileLength"]
set fileType [ascii 4 "fileType"]

while {![end]} {
	section "Chunk"
    set chunk_id [ascii 4 "Chunk ID"]
    set chunk_size [uint32 "Chunk Size"]
		switch $chunk_id {
			"SSND" {
				sectionname "SSND (Sound Data)"
				bytes $chunk_size "data"
			}
			"APPL" {
				sectionname "APPL (Application Chunk)"
				bytes $chunk_size "data"
			}
			"INST" {
				sectionname "INST (Instrument Chunk)"
				bytes $chunk_size "data"
			}
			"MARK" {
				sectionname "MARK (Marker Chunk)"
				bytes $chunk_size "data"
			}
			"COMM" {
				sectionname "COMM (Common Chunk)"
            uint16 "Num Channels"
            uint32 "Num Sample Frames"
            uint16 "Sample Size"
            hex 10 "Sample Rate"
			}

			default {
				bytes $chunk_size "data"
			}
		}
		endsection
}
