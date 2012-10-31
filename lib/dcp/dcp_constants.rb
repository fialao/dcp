class Dcp

  # Profinet (DCP) protocol ethertype.
  DCP_ETHERTYPE = 0x8892

  # BPF (Berkeley Packet Filter) for DCP.
  DCP_FILTER = "ether proto #{DCP_ETHERTYPE}"

  # Default network interface.
  DEFAULT_INTERFACE = 'eth0'

  # Default communication timeout [s].
  COMMUNICATION_TIMEOUT = 2

  ## --------------------------------------------------------------------------
  ## PACKET HEADER PARAMETERS

  # Frame ID.
  FRAME_ID = { identify_request: "\xfe\xfe", identify_response: "\xfe\xff", set: "\xfe\xfd" }

  # Service ID.
  SERVICE_ID = { set: "\x04", identify: "\x05" }

  # Service type.
  SERVICE_TYPE = { request: "\x00", success_response: "\x00" }

  # XId (transaction identification).
  XID = "\x01\x00\x00\x01"

  # Response delay.
  RESPONSE_DELAY = "\x00\x01"

  ## --------------------------------------------------------------------------
  ## PACKET RANGES

  # Source MAC address range.
  SOURCE_MAC_ADDRESS_RANGE = 6..11

  # Frame ID range.
  FRAME_ID_RANGE = 14..15

  # First block start (skip header).
  FIRST_BLOCK_START = 26

  # Set response error.
  SET_RESPONSE_ERROR = 6

  ## --------------------------------------------------------------------------
  ## PACKET BLOCKS

  # Block option.
  BLOCK_OPTION = { ip: "\x01", device: "\x02" }

  # Device block suboption.
  DEVICE_SUBOPTION = { vendor: "\x01", name: "\x02" }

  # IP block suboption.
  IP_SUBOPTION = { ip: "\x02" }

  # All selector block.
  ALL_SELECTOR_BLOCK = "\xff\xff\x00\x00"

  ## --------------------------------------------------------------------------
  ## IDENTIFY

  # Profinet multicast MAC address for identify.
  IDENTIFY_MULTICAST_MAC = '01:0e:cf:00:00:00'

  ## --------------------------------------------------------------------------
  ## SET IP

  # Determine change duration.
  CHANGE_DURATION = { temporary: "\x00\x00", permanent: "\x00\x01"}

  # Default subnet mask.
  DEFAULT_SUBNET_MASK = 24

  # Default gateway.
  DEFAULT_GATEWAY = '0.0.0.0'

end