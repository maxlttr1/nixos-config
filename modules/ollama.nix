{
  services.ollama = {
    enable = true;
    acceleration = false;
    #acceleration = "rocm"; #supported by most modern AMD GPUs
    #acceleration = "cuda"; #supported by most modern NVIDIA GPUs
  };
}