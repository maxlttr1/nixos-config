{
  swapDevices = [{
    device = "/var/lib/swapfile";
    #label = "swapfile";
    size = 32*1024; # Size is in megabytes
    priority = 2048; # Priority is a value between 0 and 32767. Higher numbers indicate higher priority. null lets the kernel choose a priority, which will show up as a negative value.
  }];

  zramSwap = {
    enable = true;
    priority = 5; # Default
  };
}