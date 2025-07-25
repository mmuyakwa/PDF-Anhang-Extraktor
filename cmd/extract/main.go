package main

import (
	"fmt"
	"os"
	"path/filepath"

	"pdf-anhang-extraktor/internal/extractor"
)

func main() {
	// Parameter überprüfen
	if len(os.Args) < 2 {
		fmt.Println("Usage: pdf-anhang-extraktor <PDF-Datei> [Name-des-Anhangs]")
		fmt.Println("  Wenn kein Anhangsname angegeben wird, wird standardmäßig 'xrechnung.xml' verwendet.")
		os.Exit(1)
	}

	pdfPath := os.Args[1]

	// Überprüfen, ob die PDF-Datei existiert
	if _, err := os.Stat(pdfPath); os.IsNotExist(err) {
		fmt.Fprintf(os.Stderr, "Fehler: Die Datei '%s' existiert nicht.\n", pdfPath)
		os.Exit(1)
	}

	// Optionalen Anhangsnamen abrufen
	var attachmentName string
	if len(os.Args) > 2 {
		attachmentName = os.Args[2]
	} else {
		// Standardwert wird in ExtractAttachment verwendet
		attachmentName = ""
	}

	// Anhang extrahieren
	outputFile, err := extractor.ExtractAttachment(pdfPath, attachmentName)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Fehler: %v\n", err)
		os.Exit(1)
	}

	// Erfolgsmeldung ausgeben
	absPath, _ := filepath.Abs(outputFile)
	fmt.Printf("Anhang erfolgreich extrahiert nach: %s\n", absPath)
}
