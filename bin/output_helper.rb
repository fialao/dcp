# Display argument (cyan colored).
def arg(argument)
  cyan = "\033[36m"
  "#{cyan}#{argument}#{clr}"
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

# Add escape character for clear all attributes.
def clr
  "\033[0m"
end