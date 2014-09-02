NWZIP:=http://dl.node-webkit.org/v0.10.3/node-webkit-v0.10.3-
NW=node-webkit-v0.10.3-
MYOS=
TARGET=app.nw

ifeq ($(OS),Windows_NT)
  MYOS=win
  NWZIP:=$(NWZIP)win-ia32.zip
  NWZIPFILE:=$(NW)win-ia32.zip
  NWZIPFILE:=$(NW)win-ia32
  NW:=$(NW)win-ia32/nw
else
  UNM=$(shell uname -s)
  ifeq ($(UNM),Darwin)
    MYOS=osx
    NWZIP:=$(NWZIP)osx-ia32.zip
    NW:=$(NW)osx-ia32/node-webkit.app/Contents/MacOS/node-webkit
    NWZIPFILE=$(shell basename $(NWZIP))
    NWZIPDIR=$(shell basename -s .zip $(NWZIP))
  endif
  ifeq ($(UNM),Linux)
    MYOS=lin
    UNP=$(shell uname -p)
    ifeq ($(UNP),x86_64)
      NW:=$(NW)linux-x64/nw
      NWZIP:=$(NWZIP)linux-x64.tar.gz
    else
      NW+=$(NW)linux-ia32/nw
      NWZIP+=$(NWZIP)linux-ia32.tar.gz
    endif
    NWZIPFILE=$(shell basename $(NWZIP))
    NWZIPDIR=$(shell basename $(NWZIP) .tar.gz)
  endif
endif

.PHONY: app
app: nw $(TARGET)

$(TARGET): index.html package.json
	npm install xlsx
	zip -r $@ $^ node_modules/

.PHONY: nw-win
nw-win:
	#if [ ! -e $(NWZIPFILE) ]; then curl -O $(NWZIP); fi
	#if [ ! -e $(NWZIPDIR) ]; then unzip $(NWZIPFILE); fi

.PHONY: nw-osx
nw-osx:
	if [ ! -e $(NWZIPFILE) ]; then curl -O $(NWZIP); fi
	if [ ! -e $(NWZIPDIR) ]; then unzip $(NWZIPFILE); fi

.PHONY: nw-lin
nw-lin:
	if [ ! -e $(NWZIPFILE) ]; then curl -O $(NWZIP); fi
	if [ ! -e $(NWZIPDIR) ]; then tar -xzf $(NWZIPFILE); fi



.PHONY: nw
nw: nw-$(MYOS)

.PHONY: test
test: $(TARGET)
	$(NW) $< $(shell pwd)/test.xlsx

.PHONY: clean
clean:
	rm -f $(TARGET) $(NWZIPFILE)
	rm -rf $(NWZIPDIR)

