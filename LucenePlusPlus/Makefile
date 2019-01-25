CC=g++
INCFLAG=-Ilib/luceneplusplus-3.0.7/include/lucene++
LIBFLAG=-Llib/luceneplusplus-3.0.7/lib
CFLAGS=-std=gnu++11
LIBS=-lpthread -lboost_system -llucene++ -llucene++-contrib -lpthread -lboost_thread 

all:
	mkdir -p bin
	$(CC) $(INCFLAG) $(LIBFLAG) $(CFLAGS) -o bin/XSearchData.exe \
		src/XSearchData.cpp $(LIBS)

clean:
	$(RM) -r bin/*.exe
