{
    services.fail2ban = {
        enable = true;
        maxretry = 5;
        bantime = "1h";
        bantime-increment = {
            enable = true;
            maxtime = "168h"; # Do not ban for more than 1 week
            overalljails = true; # Calculate the bantime based on all the violations
        };
    };
}