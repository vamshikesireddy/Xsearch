**Illinois Institute of Technology**  
**CS554 Data-Intensive Computing (Fall 2018)**  
**XSearch Project**  
Project mentor: Alexandru Iulian Orhean (aorhean@hawk.iit.edu)

# Description

This repository contains and example of two implementations of a simple search
engine: one implementation using the objects and classes found in the Apache 
Lucene information library and the second one using the constructs provided by
the LucenePlusPlus (Lucene++) information retrieval library, which is an
efficient C++ port of Lucene. Feel free to use the provided code as the base of
your CS554 project.

# Requirements

The data for the experiments is assumed to reside in the *Data* directory, and
it is also assumed that the file that contains the path to the files that are to
be indexed *Data/input.dat* and the file that contains the terms to be searched
*Data/terms.dat*, but all of these files can be changed as long as the
iterations scripts are also updated. Both implementations have setup scripts
that download and build all the dependencies and they were tested on Ubuntu
16.04 and Ubuntu 18.04. For the setup script to work on other distributions,
certain modifications need to be made at the step where it installs distribution
dependent packages.

# How to build and run

## Apache Lucene

All the command are assumed to be run from the *Lucene* directory:

$ cd Lucene

In order to build and run the implementation you first need to download Lucene
and you need to install Java 8 JDK, apache ant and ivy. You can do this by using
the setup script:

$ ./scripts/setup.sh

The script is going to create two directories: *Lucene/download* and
*Lucene/lib*, that contain the Lucene source code and the compiled library
respectively. Then you need to build the search engine application, with the
source code in *Lucene/src/XSearchData.java*, by running make:

$ make

The Makefile also has a make clean command. You can run the application
directly, but you need to set up the CLASSPATH variable before:

$ export CLASSPATH="lib/lucene-7.1.0/build/core/classes/java/:bin"  
$ java XSearchData ../Data/input.dat ../Data/terms.dat

There is also a script that runts multiple iterations of the application and is
useful if you want to run different scenarios all one after another without
having to supervise them:

$ ./scripts/iterate.sh

This will create a log file containing the concatenated outputs of all the
iterations, in the order they ran there, and is named according to the date and
time the iterations ran.

## LucenePlusPlus

All the command are assumed to be run from the *LucenePlusPlus* directory:

$ cd LucenePlusPlus

In order to build and run the implementation you first need to clone the
LucenePlusPlus repository and you need to install gcc, g++, cmake, 
libboost-date-time-dev, libboost-filesystem-dev, libboost-regex-dev, 
libboost-thread-dev and libboost-iostreams-dev. You can do this by using the 
setup script:

$ ./scripts/setup.sh

The script is going to create two directories: *LucenePlusPlus/download* and
*LucenePlusPlus/lib*, that contain the LucenePlusPlus source code and the 
compiled library respectively. Then you need to build the search engine 
application, with the source code in *LucenePlusPlus/src/XSearchData.cpp*, by 
running make:

$ make

The Makefile also has a make clean command. You can run the application
directly, but you need to set up the LD_LIBRARY_PATH and LC_ALL variables 
before:

$ export LD_LIBRARY_PATH="lib/luceneplusplus-3.0.7/lib"  
$ export LC_ALL="en_US.UTF-8"  
$ ./bin/XSearchData.exe ../Data/input.dat ../Data/terms.dat

There is also a script that runts multiple iterations of the application and is
useful if you want to run different scenarios all one after another without
having to supervise them:

$ ./scripts/iterate.sh

This will create a log file containing the concatenated outputs of all the
iterations, in the order they ran there, and is named according to the date and
time the iterations ran.
