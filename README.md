# Docker image for running IPOPP v3+

This repo builds a docker image for running the NASA Direct Readout Laboratory - International Polar Orbiter Processing Package [IPOPP software](https://directreadout.sci.gsfc.nasa.gov/?id=dspContent&cid=68) that transforms direct-broadcast MODIS TERRA and AQUA, Suomi-NPP/JPSS1 VIIRS, ATMS, and CrIS Raw Data Record (RDR) products to Sensor Data Record (SDR) products on Intel Linux computers. It is an alternative to the University of Wisconsin SSEC [CIMSS CSPP](http://cimss.ssec.wisc.edu/cspp/) software.

    - Due to the huge size of the software (tens of gigabyte), IPOPP itself is not included in the docker image.

    - Consult the IPOPP User Guide for up-to-date hardware/VM requirements.

    - If you're still using IPOPP v2+, upgrade as soon as possible because it will fail to download ancillary data for processing real soon now.

This is a revision of the previous repo, https://bitbucket.org/cheewai/drl-ipopp
