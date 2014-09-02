# XLSX node-webkit demo

This has been tested using the prebuilt nw 0.10.3 binary

## Installation

After getting the files, run `make` to create an "app.nw" file.  If `nw` is on your path, `make test` will fire up the app and attempt to open `test.xlsx`

## Usage

    nw app.nw your_xlsx_file

## Notes

Even though OSX and Linux let you use relative paths, absolute paths to the XLSX
files must be used on Windows.
