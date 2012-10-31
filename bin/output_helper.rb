# Display argument (cyan colored).
def arg(argument)
  cyan = "\033[36m"
  "#{cyan}#{argument}#{clr}"
end

# Add done message (green colored).
def done
  green = "\033[32m"
  return "#{set_to_info}[ #{green}Done#{clr} ]"
end

# Add failed message (red colored).
def failed
  red = "\033[31m"
  return "#{set_to_info}[ #{red}Failed#{clr} ]"
end

# Display inaccessible device (red colored).
def inaccessible(device)
  red = "\033[31m"
  return "#{red}#{device}#{clr}"
end

# Display inaccessible device (red colored).
def conflict(device)
  light_red = "\033[41m"
  return "#{light_red}#{device}#{clr}"
end

# Add escape character for go one line up and set cursor to column 70.
def set_to_info
"\033[1A\033[70C"
end

# Add escape character for clear all attributes.
def clr
  "\033[0m"
end