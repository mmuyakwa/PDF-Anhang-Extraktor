package utils

import (
	"io/ioutil"
	"os"
)

// WriteToFile writes data to a specified file.
func WriteToFile(filename string, data []byte) error {
	return ioutil.WriteFile(filename, data, 0644)
}

// ReadFromFile reads data from a specified file.
func ReadFromFile(filename string) ([]byte, error) {
	return ioutil.ReadFile(filename)
}