class Dcp

  # Profinet (DCP) protocol ethertype.
  DCP_ETHERTYPE = 0x8892

  # BPF (Berkeley Packet Filter) for DCP.
  DCP_FILTER = "ether proto #{DCP_ETHERTYPE}"

  # Default network interface.
  DEFAULT_INTERFACE = 'eth0'

  ## --------------------------------------------------------------------------
  ## IDENTIFY

  # Profinet multicast MAC address for identify
  IDENTIFY_MULTICAST_MAC = '01:0e:cf:00:00:00'

  # Default identify timeout [s].
  IDENTIFY_TIMEOUT = 3

  # Block option
  IDENTIFY_BLOCK_OPTION = { ip: "\x01", device: "\x02" }

  # Device block suboption
  IDENTIFY_DEVICE_BLOCK = { vendor: "\x01", name: "\x02" }

  # IP block suboption
  IDENTIFY_IP_BLOCK = { ip: "\x02" }

  ## --------------------------------------------------------------------------
  ## PACKET PARAMETERS

  # Frame Id
  FRAME_ID = { identify_request: "\xfe\xfe", identify_response: "\xfe\xff" }

  # Service Id
  SERVICE_ID = { identify: "\x05" }

  # Service Type
  SERVICE_TYPE = { request: "\x00", success_response: "\x00" }

  # XId (transaction identification)
  XID = "\x01\x00\x00\x01"

  # Response Delay
  RESPONSE_DELAY = "\x00\x01"

  ## --------------------------------------------------------------------------
  ## PACKET RANGES
  
  # Source MAC address range
  SOURCE_MAC_ADDRESS_RANGE = 6..11

  # Frame Id range
  FRAME_ID_RANGE = 14..15

  # Identify response start
  IDENTIFY_RESPONSE_START = 26

  ## --------------------------------------------------------------------------
  ## PACKET BLOCKS

  # All selector block
  ALL_SELECTOR_BLOCK = "\xff\xff\x00\x00"

end