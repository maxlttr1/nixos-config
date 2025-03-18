{
    networking.networkmanager = {
        enable = true;
        ethernet.macAddress = "random"; #  Generate a randomized value upon each connect
        wifi.macAddress = "random";
    };
}
