# Main header

seekto 0x0
read ascii string length 8 as $signature
read int16 as $channels
read int16 as $bits_per_sample
read int32 as $samplerate
read int32 as $num_samples
read int32 as $blocks_offset
read int32 as $data_offset
read int32 as $data_size

# Block headers

set $num_blocks [expr {($data_offset - $blocks_offset) / 4}]

for {set i 0} {$i < $num_blocks} {incr i} {
  seekto [expr $blocks_offset + $i * 4]
  read int32 as $block_offset

  seekto $block_offset
  read int32 as $block_signature
  read int32 as $base_value
  read int16 as $bits
  read int16 as $flags
}

# Data

seekto $data_offset
read bytes $data_size as $data

# Format and display

format "File signature: %s\n" $signature
format "Channels: %d\n" $channels
format "Bits per sample: %d\n" $bits_per_sample
format "Sample rate: %d Hz\n" $samplerate
format "Number of samples: %d \n" $num_samples
format "Data size: %d bytes\n" $data_size
format "Number of blocks: %d\n" $num_blocks

foreach block_header {
  format "Block signature: 0x%08X\n" $block_signature
  format "Base value: %d\n" $base_value
  format "Bits: %d\n" $bits
  format "Flags: 0x%04X\n" $flags
}

display_comment "Block data..."
hexdump $data
