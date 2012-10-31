# IP address with needful operations.
#
# Author: Ondra Fiala, mailto:ondra.fiala@gmail.com
# Version: 0.1.0
class IpAddress

  # IP address [String]
  attr_accessor :address

  # Subnet mask [Fixnum]
  attr_accessor :subnet_mask

  # Default constructor.
  #
  # @params [String] ip_address ip address and subnet mask as bit-length of the prefix (e.g. 192.168.0.1/24)
  def initialize(*ip_address)
    ip_address    = ip_address.first.split('/') if ip_address.size == 1
    @address      = ip_address[0]
    @subnet_mask  = ip_address[1].to_i
  end

  # Creates object from network interface.
  #
  # @param [String] interface Netork interface name.
  # @return [IpAddress] new object with ip address and subnet mask acquired from interface
  def self.from_interface(interface)
    ifconfig_data = `ifconfig #{interface}`
    ifconfig_data.match /inet ([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+) netmask (0x[0-9a-z]+)/
    self.new($1, $2.hex.to_s(2).count('1'))
  end

  # IP address and subnet mask separated with slash as String.
  #
  # @return [String] ip address and subnet mask separated with slash
  def to_s
    "#{@address}/#{@subnet_mask}"
  end

  # IP address as FixNumber.
  #
  # @return [FixNumber] ip address
  def to_i
    @address.split('.').map(&:to_i).pack('C*').unpack('N').first
  end

  # IP address family as ip address range (first..last ip address in accessible range).
  #
  # @return [Range] ip address family as range
  def to_range
    mask          = ((1 << @subnet_mask) - 1) << (32 - @subnet_mask)
    ip_address    = to_i
    first_address = (ip_address & mask) + 1
    last_address  = (ip_address | mask.ones_complement(32)) - 1
    first_address..last_address
  end

  # Check, if ip address is accessible from itself (current ip address range).
  #
  # @param [IpAddress] ip_address object for testing
  # @return [Boolean]  indicates, if ip address is accessible from itself
  def access?(ip_address)
    to_range.include? ip_address.to_i
  end

  # Check, if ip addess and itself is mutually accessible.
  #
  # @param [IpAddress] ip_address object for testing
  # @return [Boolean]  indicates, if ip address and itself is mutually accessible
  def ===(ip_address)
    self.access?(ip_address) && ip_address.access?(self)
  end

end