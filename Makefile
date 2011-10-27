ROOT=/cluster/home/ted/PINAX
SOURCES=Makefile README


all : 

install : python


python : Python-2.7.2 
	cd $< && ./configure --prefix=/cluster/home/ted/MedBook0/python
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
