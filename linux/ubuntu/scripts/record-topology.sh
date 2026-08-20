#! /usr/bin/env bash

# Print script start timestamp and source file
printf "%s\n" "$(date), $(tput bold)${BASH_SOURCE[0]}$(tput sgr0)"

# Default values for configuration
export LOCKER="${LOCKER:-$HOME/.info/${moniker}}"  # Default locker directory for storing outputs
export FILE_BASE="${LOCKER}/lstopo"    # Base file name for lstopo outputs
export OUTPUT_FORMAT="${OUTPUT_FORMAT:-ascii}"  # Default output format (ascii)
export FORCE="${FORCE:-false}"         # Overwrite existing files if set to true
EXTRA_OPTIONS=""                       # Additional options passed to lstopo

# Ensure the locker directory exists
mkdir -p "$LOCKER"

# Usage instructions for the script
usage() {
    echo "Usage: $0 [--output-format <format>] [--force] [additional-options]"
    echo
    echo "Examples:"
    echo "  1. Basic usage (default format is ascii):"
    echo "     $0"
    echo
    echo "  2. Specify output format as SVG:"
    echo "     $0 --output-format svg"
    echo
    echo "  3. Overwrite existing files and include verbose output:"
    echo "     $0 --force --verbose"
    echo
    echo "Supported formats: console, ascii, tikz, fig, svg, xml, synthetic"
    exit 1
}

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --output-format|--of)
            OUTPUT_FORMAT="$2"  # Set the desired output format
            shift 2
            ;;
        --force|-f)
            FORCE=true  # Enable forced overwrite of existing files
            shift
            ;;
        -*)
            EXTRA_OPTIONS="$EXTRA_OPTIONS $1"  # Capture additional options
            shift
            ;;
        *)
            echo "Unknown option: $1"
            usage  # Show usage instructions for invalid input
            ;;
    esac
done

# Verify if lstopo is installed
if ! command -v lstopo &> /dev/null; then
    echo "Error: lstopo not found. Please install it and try again."
    exit 1
fi

# Define the primary output file based on the requested format
OUTPUT_FILE="${FILE_BASE}.${OUTPUT_FORMAT}"

# Handle force overwrite option
if [ -f "$OUTPUT_FILE" ] && [ "$FORCE" = "true" ]; then
    echo "Forcing overwrite: Removing existing $OUTPUT_FILE"
    rm "$OUTPUT_FILE"
fi

# Generate the main output file if it doesn't already exist
if [ ! -f "$OUTPUT_FILE" ]; then
    echo "Generating lstopo output: $OUTPUT_FILE"
    lstopo --of "$OUTPUT_FORMAT" $EXTRA_OPTIONS "$OUTPUT_FILE"
else
    echo "Skipping generation: $OUTPUT_FILE already exists. Use --force to overwrite."
fi

# Define additional outputs with descriptive keys
declare -A ADDITIONAL_FILES=(
    ["verbose"]="${FILE_BASE}-v.txt"  # Detailed textual output
    ["physical"]="${FILE_BASE}-p.txt"  # Physical indexes output
    ["pdf"]="${FILE_BASE}.pdf"  # Graphical output in PDF
    ["png"]="${FILE_BASE}.png"  # Graphical output in PNG
)

# Generate additional outputs if they don't exist
for key in "${!ADDITIONAL_FILES[@]}"; do
    file="${ADDITIONAL_FILES[$key]}"
    if [ ! -f "$file" ]; then
        echo "Generating additional output: $file"
        lstopo "--$key" "$file" > /dev/null 2>&1
    else
        echo "Skipping additional output: $file already exists."
    fi
done

# Final message indicating script completion
echo "lstopo script completed."

# Examples of usage
if [[ "$1" == "--examples" ]]; then
    usage
fi

