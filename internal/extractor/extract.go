package extractor

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"

	"github.com/pdfcpu/pdfcpu/pkg/api"
)

// StandardAnhangName ist der Standard-Dateiname des zu extrahierenden Anhangs
const StandardAnhangName = "xrechnung.xml"

// ExtractAttachment extrahiert einen Anhang aus einer PDF-Datei
// Wenn attachmentName leer ist, wird StandardAnhangName verwendet
func ExtractAttachment(pdfPath, attachmentName string) (string, error) {
	// Wenn kein Anhangsname angegeben wurde, verwende den Standard
	if attachmentName == "" {
		attachmentName = StandardAnhangName
	}

	// Zieldateinamen aus dem PDF-Namen ableiten
	base := strings.TrimSuffix(filepath.Base(pdfPath), filepath.Ext(pdfPath))
	target := base + filepath.Ext(attachmentName)

	// Auflisten aller Anhänge
	attachments, err := api.ListAttachmentsFile(pdfPath, nil)
	if err != nil {
		return "", fmt.Errorf("fehler beim Lesen der Anhänge: %v", err)
	}

	// Nach dem gewünschten Anhang suchen
	var found bool
	for _, att := range attachments {
		if att == attachmentName {
			err := extractOne(pdfPath, attachmentName, target)
			if err != nil {
				return "", fmt.Errorf("fehler beim Extrahieren: %v", err)
			}
			found = true
			break
		}
	}

	if !found {
		return "", fmt.Errorf("kein Anhang namens '%s' gefunden", attachmentName)
	}

	return target, nil
}

// extractOne extrahiert einen einzelnen Anhang aus einer PDF-Datei
func extractOne(pdfPath, attachmentName, outFile string) error {
	// Verzeichnis für die Extraktion vorbereiten
	tempDir, err := os.MkdirTemp("", "pdf-extract-*")
	if err != nil {
		return fmt.Errorf("fehler beim Erstellen des temporären Verzeichnisses: %v", err)
	}
	defer os.RemoveAll(tempDir)

	// Anhang in das temporäre Verzeichnis extrahieren
	err = api.ExtractAttachmentsFile(pdfPath, tempDir, []string{attachmentName}, nil)
	if err != nil {
		return fmt.Errorf("fehler beim Extrahieren des Anhangs: %v", err)
	}

	// Extrahierte Datei finden und zum Zielort kopieren
	extractedFilePath := filepath.Join(tempDir, attachmentName)
	data, err := os.ReadFile(extractedFilePath)
	if err != nil {
		return fmt.Errorf("fehler beim Lesen der extrahierten Datei: %v", err)
	}

	// Inhalt in die Zieldatei schreiben
	return os.WriteFile(outFile, data, 0644)
}
