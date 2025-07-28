# PDF Attachment Extractor

This Go-based tool is designed to extract attachments from PDF files and is particularly relevant for electronic invoices in the ZUGFeRD format with the XRechnung profile. Often, these E-Invoices contain an XML file named "xrechnung.xml" as an attachment in the PDF. With the PDF Attachment Extractor, you can conveniently extract these or other specific attachments from the PDF and save them as separate files.

## UseCase

Especially for users who regularly process E-Invoices (ZUGFeRD/XRechnung), it is often necessary to extract the XML structure (e.g., "xrechnung.xml") for further processing or validation. This tool automates the extraction process, saving time and manual work steps.

## Prerequisites

- Go ≥ 1.18
- All required dependencies are automatically managed via `go.mod`.

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/mmuyakwa/PDF-Anhang-Extraktor.git
   cd pdf-anhang-extraktor
   ```

2. Install dependencies:

   ```bash
   go mod tidy
   ```

## Usage

To use the tool, run the following command:

```bash
go run cmd/extract/main.go <path-to-PDF-file> [attachment-name]
```

- `<path-to-PDF-file>`: Path to the PDF file containing one or more attachments.
- `[attachment-name]` (optional): Name of the specific attachment to be extracted.
  If no attachment name is provided, the tool automatically attempts to find and extract an attachment named `xrechnung.xml`.

### Examples

1. Extraction with default attachment (xrechnung.xml):

   ```bash
   go run cmd/extract/main.go Example.pdf
   ```

2. Extraction of a specific attachment:

   ```bash
   go run cmd/extract/main.go Example.pdf specific-attachment.xml
   ```

## Building

To build the application for all supported platforms automatically, use the provided build script:

```bash
# Make script executable
chmod +x build.sh

# Build for all platforms
./build.sh

# Or use Make
make build-all
```

This will create binaries for all supported operating systems and architectures in the `builds/` directory.

## Tests

To run the tests, use the following command:

```bash
go test ./...
```

## Cross-compilation for Different Operating Systems

Go enables cross-compiling to create binaries for different platforms. Here are some examples:

### Windows

```bash
set GOOS=windows
set GOARCH=amd64
go build -o pdf-extraktor.exe cmd/extract/main.go
```

### Linux

```bash
set GOOS=linux
set GOARCH=amd64
go build -o pdf-extraktor cmd/extract/main.go
```

On Linux or macOS:

```bash
GOOS=linux GOARCH=amd64 go build -o pdf-extraktor cmd/extract/main.go
```

### macOS

```bash
set GOOS=darwin
set GOARCH=amd64
go build -o pdf-extraktor cmd/extract/main.go
```

On Linux or macOS:

```bash
GOOS=darwin GOARCH=amd64 go build -o pdf-extraktor cmd/extract/main.go
```

### ARM-based Systems (e.g., Raspberry Pi)

```bash
set GOOS=linux
set GOARCH=arm
go build -o pdf-extraktor cmd/extract/main.go
```

The created binaries can then be executed on target systems without a Go installation.

## Notes

- Make sure the PDF file actually contains an attachment (e.g., `xrechnung.xml`).
- If no attachment name is specified, the program automatically searches for `xrechnung.xml`.
- For questions or issues, feel free to contact the developers.

## Language Versions

- [German Version (Deutsche Version)](README_DE.md)
