ROOT=/cluster/home/ted/PINAX
SOURCES=Makefile README


all : 

Python-2.7.2 : Python-2.7.2.tgz
	tar xvfz $<

Python-2.7.2.tgz: 
	wget http://www.python.org/ftp/python/2.7.2/Python-2.7.2.tgz

Pinax-0.7.3-bundle.tar.gz:
	wget http://downloads.pinaxproject.com/Pinax-0.7.3-bundle.tar.gz


push:
	git commit -m "Updating minor changes" $(SOURCES)
	git push origin master
