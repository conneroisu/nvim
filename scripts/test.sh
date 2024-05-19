#!/bin/bash
# timeout 120 nvim --headless

# Trap SIGTERM 
#
# Write a bash script that traps SIGTERM signal and then runs: timeout 120 nvim --headless

# Function to handle SIGTERM signal
handle_sigterm() {
    echo "SIGTERM received. Exiting nvim."
    exit 0
}

# Trap SIGTERM signal and call the handle_sigterm function
trap 'handle_sigterm' SIGTERM

# Start nvim in headless mode with a 120 seconds timeout
timeout 120 nvim --headless &

# Wait for nvim to finish
wait $!
