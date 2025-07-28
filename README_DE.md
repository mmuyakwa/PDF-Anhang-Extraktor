# PDF-Anhang-Extraktor

Dieses Go-basierte Tool dient zur Extraktion von Anhängen aus PDF-Dateien und ist insbesondere für elektronische Rechnungen im ZUGFeRD-Format mit dem Profil XRechnung relevant. Häufig liegt in diesen E-Invoices eine XML-Datei namens "xrechnung.xml" im Anhang der PDF vor. Mit dem PDF-Anhang-Extraktor kannst du diese oder andere spezifische Anhänge bequem aus der PDF ziehen und in separaten Dateien speichern.

## Anwendungsfall

Gerade für Anwenderinnen und Anwender, die regelmäßig E-Invoices (ZUGFeRD/XRechnung) verarbeiten, ist es oft notwendig, die XML-Struktur (z. B. "xrechnung.xml") zu extrahieren, um sie weiterzuverarbeiten oder zu validieren. Dieses Tool automatisiert den Extraktionsvorgang und spart damit Zeit und manuelle Arbeitsschritte.

## Voraussetzungen

- Go ≥ 1.18
- Alle benötigten Abhängigkeiten werden automatisch über `go.mod` verwaltet.

## Installation

1. Repository klonen:

   ```bash
   git clone <repository-url>
   cd pdf-anhang-extraktor
   ```

2. Abhängigkeiten installieren:

   ```bash
   go mod tidy
   ```

## Verwendung

Um das Tool zu nutzen, führst du folgenden Befehl aus:

```bash
go run cmd/extract/main.go <Pfad-zur-PDF-Datei> [Name-des-Anhangs]
```

- `<Pfad-zur-PDF-Datei>`: Pfad zu der PDF-Datei, die einen oder mehrere Anhänge enthält.
- `[Name-des-Anhangs]` (optional): Name des spezifischen Anhangs, der extrahiert werden soll.
  Wird kein Anhangsname angegeben, versucht das Tool automatisch, einen Anhang namens `xrechnung.xml` zu finden und zu extrahieren.

### Beispiele

1. Extraction mit Standardanhang (xrechnung.xml):

   ```bash
   go run cmd/extract/main.go Beispiel.pdf
   ```

2. Extraktion eines spezifischen Anhangs:

   ```bash
   go run cmd/extract/main.go Beispiel.pdf spezifischer-anhang.xml
   ```

## Kompilierung

Um die Anwendung automatisch für alle unterstützten Plattformen zu kompilieren, verwende das bereitgestellte Build-Skript:

```bash
# Skript ausführbar machen
chmod +x build.sh

# Alle Plattformen bauen
./build.sh

# Oder über Make
make build-all
```

Dies erstellt Binärdateien für alle unterstützten Betriebssysteme und Architekturen im `builds/`-Verzeichnis.

## Tests

Um die Tests auszuführen, verwende folgenden Befehl:

```bash
go test ./...
```

## Kompilierung für verschiedene Betriebssysteme

Go ermöglicht Cross-Compiling, um Binärdateien für unterschiedliche Plattformen zu erstellen. Nachfolgend einige Beispiele:

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

Unter Linux bzw. macOS:

```bash
GOOS=linux GOARCH=amd64 go build -o pdf-extraktor cmd/extract/main.go
```

### macOS

```bash
set GOOS=darwin
set GOARCH=amd64
go build -o pdf-extraktor cmd/extract/main.go
```

Unter Linux bzw. macOS:

```bash
GOOS=darwin GOARCH=amd64 go build -o pdf-extraktor cmd/extract/main.go
```

### ARM-basierte Systeme (z. B. Raspberry Pi)

```bash
set GOOS=linux
set GOARCH=arm
go build -o pdf-extraktor cmd/extract/main.go
```

Die erstellten Binärdateien können anschließend ohne Go-Installation auf den Zielsystemen ausgeführt werden.

## Hinweise

- Stelle sicher, dass die PDF-Datei tatsächlich einen Anhang (z. B. `xrechnung.xml`) enthält.  
- Wird kein Anhangsname angegeben, so sucht das Programm automatisch nach `xrechnung.xml`.
- Bei Fragen oder Problemen kannst du dich gerne an die Entwickler wenden.

## Sprachversionen

- [English Version (Englische Version)](README.md)
