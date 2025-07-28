#!/bin/bash

# Build script for cross-platform compilation
# Creates binaries for multiple operating systems and architectures

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Project settings
BINARY_NAME="pdf-extraktor"
SOURCE_PATH="./cmd/extract/main.go"
BUILD_DIR="builds"

echo -e "${BLUE}=== PDF Attachment Extractor - Cross Platform Build ===${NC}"
echo ""

# Create or clean builds directory
if [ -d "$BUILD_DIR" ]; then
    echo -e "${YELLOW}Cleaning existing builds directory...${NC}"
    rm -rf "$BUILD_DIR"/*
else
    echo -e "${YELLOW}Creating builds directory...${NC}"
    mkdir -p "$BUILD_DIR"
fi

# Build function
build_binary() {
    local os=$1
    local arch=$2
    local extension=$3
    local output_name="${BINARY_NAME}"
    
    if [ ! -z "$extension" ]; then
        output_name="${output_name}.${extension}"
    fi
    
    local output_path="${BUILD_DIR}/${os}-${arch}/${output_name}"
    local dir_path="${BUILD_DIR}/${os}-${arch}"
    
    echo -e "${BLUE}Building for ${os}/${arch}...${NC}"
    
    # Create directory for this platform
    mkdir -p "$dir_path"
    
    # Set environment variables and build
    GOOS=$os GOARCH=$arch go build -ldflags="-s -w" -o "$output_path" "$SOURCE_PATH"
    
    if [ $? -eq 0 ]; then
        # Get file size
        local size=$(du -h "$output_path" | cut -f1)
        echo -e "${GREEN}✓ Successfully built ${os}/${arch} (${size})${NC}"
        
        # Create a simple README for each platform
        cat > "$dir_path/README.txt" << EOF
PDF Attachment Extractor - ${os}/${arch}
========================================

Usage:
  ./${output_name} <path-to-PDF-file> [attachment-name]

Examples:
  ./${output_name} invoice.pdf
  ./${output_name} invoice.pdf custom-attachment.xml

For more information, see the main README.md file.
EOF
    else
        echo -e "${RED}✗ Failed to build ${os}/${arch}${NC}"
        return 1
    fi
}

echo -e "${YELLOW}Starting cross-compilation...${NC}"
echo ""

# Build for different platforms
# Format: build_binary OS ARCH EXTENSION

# Windows
build_binary "windows" "amd64" "exe"
build_binary "windows" "386" "exe"
build_binary "windows" "arm64" "exe"

# Linux
build_binary "linux" "amd64" ""
build_binary "linux" "386" ""
build_binary "linux" "arm64" ""
build_binary "linux" "arm" ""

# macOS
build_binary "darwin" "amd64" ""
build_binary "darwin" "arm64" ""

# FreeBSD
build_binary "freebsd" "amd64" ""
build_binary "freebsd" "386" ""

# Additional platforms (optional)
# build_binary "openbsd" "amd64" ""
# build_binary "netbsd" "amd64" ""

echo ""
echo -e "${GREEN}=== Build Summary ===${NC}"

# Show build results
if [ -d "$BUILD_DIR" ]; then
    echo -e "${BLUE}Built binaries:${NC}"
    find "$BUILD_DIR" -name "$BINARY_NAME*" -type f | while read file; do
        size=$(du -h "$file" | cut -f1)
        echo -e "  ${GREEN}$file${NC} (${size})"
    done
    
    echo ""
    echo -e "${BLUE}Directory structure:${NC}"
    tree "$BUILD_DIR" 2>/dev/null || find "$BUILD_DIR" -type f | sed 's|[^/]*/|  |g'
    
    echo ""
    echo -e "${GREEN}✓ All builds completed successfully!${NC}"
    echo -e "${YELLOW}Binaries are available in the '${BUILD_DIR}' directory${NC}"
else
    echo -e "${RED}✗ Build directory not found${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}To test a binary, run:${NC}"
echo -e "  ${YELLOW}./${BUILD_DIR}/linux-amd64/${BINARY_NAME} --help${NC}"