{
    networking.networkmanager = {
        enable = true;
        ethernet.macAddress = "random"; #  Generate a randomized value upon each connect
        wifi.macAddress = "random";
        wifi.scanRandMacAddress = true; # Whether to enable MAC address randomization of a Wi-Fi device during scanning.w
    };
}
