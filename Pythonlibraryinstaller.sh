#!/bin/bash

# Function to prompt for user input
get_user_input() {
    echo "What do you use Python for?"
    echo "1. Data Science"
    echo "2. Web Development"
    echo "3. Machine Learning"
    echo "4. Other"
    echo "Please choose from 1-4: "
    read choice
}

# Function to suggest libraries based on purpose
suggest_libraries() {
    case $choice in
        1)
            purpose="Data Science"
            libraries=("numpy" "pandas" "matplotlib" "scipy" "seaborn")
            ;;
        2)
            purpose="Web Development"
            libraries=("flask" "django" "requests" "beautifulsoup4")
            ;;
        3)
            purpose="Machine Learning"
            libraries=("tensorflow" "keras" "scikit-learn" "xgboost")
            ;;
        4)
            purpose="Other"
            libraries=()
            echo "Please specify the libraries you need (separated by space):"
            read -a libraries
            ;;
        *)
            echo "Invalid choice. Please run the script again and select a valid option."
            exit 1
            ;;
    esac
}

# Function to display libraries and their purpose
display_libraries() {
    echo "The following libraries are suggested for $purpose:"
    for lib in "${libraries[@]}"; do
        echo "- $lib"
    done
}

# Function to show disk space requirements
check_disk_space() {
    echo "Checking disk space requirements..."
    required_space=$(( ${#libraries[@]} * 100 )) # Assuming each library requires 100MB
    echo "Approximate space required: $required_space MB"
    echo "Current available space:"
    df -h .
}

# Function to prompt for download
prompt_for_download() {
    echo "Do you want to download the libraries now? (yes/no)"
    read download_choice
}

# Function to download libraries
download_libraries() {
    if [[ "$download_choice" == "yes" || "$download_choice" == "y" ]]; then
        for lib in "${libraries[@]}"; do
            echo "Downloading $lib..."
            pip download $lib
        done
        echo "Download completed."
    else
        echo "Download postponed."
        exit 0
    fi
}

# Function to prompt for installation
prompt_for_install() {
    echo "Do you want to install the libraries now? (yes/no)"
    read install_choice
}

# Function to install libraries
install_libraries() {
    if [[ "$install_choice" == "yes" || "$install_choice" == "y" ]]; then
        for lib in "${libraries[@]}"; do
            echo "Installing $lib..."
            pip install $lib
        done
        echo "Installation completed."
    else
        echo "Installation postponed."
        exit 0
    fi
}

# Main script execution
get_user_input
suggest_libraries
display_libraries
check_disk_space
prompt_for_download
download_libraries
prompt_for_install
install_libraries
