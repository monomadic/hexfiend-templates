section "header" {
	bytes 8 "signature"
	uint16 "channels"
	uint16 "bits_per_sample"
	uint32 "sample_rate"
	uint32 "num_samples"
	uint32 "block_address_offset"
	set dataOffsetPos [uint32 "block_headers_offset"]
	uint32 "block_data_len"
	bytes 88 "padding"
}

section "block_address_list" {
	while {[pos] < $dataOffsetPos} {
		uint32 "block_offset"
	}
}

section "block_data" {
	section "block_header" {
		uint32 "signature"
		uint32 "base_value"
		uint16 "bits"
		uint16 "flags"
		uint32 "padding"
	}
	bytes 512
}


section "block_data" {
	section "block_header" {
		uint32 "signature"
		uint32 "base_value"
		uint16 "bits"
		uint16 "flags"
		uint32 "padding"
	}
	bytes 512
}
