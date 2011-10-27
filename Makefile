ROOT=/cluster/home/ted/MedBook0
SOURCES=Makefile README


all : install

install : python PIL

PIL: python
	mkdir -p python/PIL/
	echo 'cd python/PIL/ && wget http://effbot.org/downloads/Imaging-1.1.7.tar.gz'
	echo 'cd python/PIL/ && tar xvfz Imaging-1.1.7.tar.gz'
	cd python/PIL/Imaging-1.1.7 && $(ROOT)/python/bin/python setup.py install
	

python: python/bin/python

python/bin/python : Python-2.7.2 libs
	cd $< && ./configure --prefix=$(ROOT)/python -libdir=$(ROOT)/libs/lib
	cd $< && make install

python/bin/ez_setup.py: python
	cd  python/bin/ && wget http://peak.telecommunity.com/dist/ez_setup.py
	chmod 755 $@
	python/bin/python python/bin/ez_setup.py

Python-2.7.2 : Python-2.7.2.tgz
	tar xvfz $<
	touch $@

Python-2.7.2.tgz: 
	wget http://www.python.org/ftp/python/2.7.2/Python-2.7.2.tgz

Pinax-0.7.3-bundle.tar.gz:
	wget http://downloads.pinaxproject.com/Pinax-0.7.3-bundle.tar.gz


push:
	git commit -m "Updating minor changes" $(SOURCES)
	git push origin master

libs: libs/lib/libjpeg.so libs/lib/libz.so libs/lib/libtcl8.5.so

libs/lib/libjpeg.so:
	mkdir -p libs
	cd libs && wget http://www.ijg.org/files/jpegsrc.v8c.tar.gz
	cd libs && tar xvfz jpegsrc.v8c.tar.gz
	cd libs/jpeg-8c  && ./configure --prefix=/cluster/home/ted/MedBook0/libs/
	cd libs/jpeg-8c  && make install

libs/lib/libz.so:
	mkdir -p libs
	cd libs && wget http://zlib.net/zlib-1.2.5.tar.gz
	cd libs && tar xvfz zlib-1.2.5.tar.gz
	cd libs/zlib-1.2.5  && ./configure --prefix=/cluster/home/ted/MedBook0/libs/
	cd libs/zlib-1.2.5 && make install


libs/lib/libtcl8.5.so :
	echo 'cd libs && wget http://prdownloads.sourceforge.net/tcl/tcl8.5.10-src.tar.gz/'
	echo 'cd libs && tar xvf tcl8.5.10-src.tar.gz/'
	cd libs/tcl8.5.10/unix && autoconf  && ./configure --prefix=/cluster/home/ted/MedBook0/libs/
	cd libs/tcl8.5.10/unix && make install
