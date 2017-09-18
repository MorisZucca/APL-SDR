# APL-SDR
## Software defined radio software written in APL

Steps to use an RTL device with the Dyalog APL interpreter:
* Plug in the device
* Change the default drivers to WinUSB (you can use [Zadig](http://zadig.akeo.ie/) for this step, ensure to choose the correct device before applying the driver replacement)
* Download the rtlsdr dlls from the Osmocom website (precompiled binaries for windows [here](http://osmocom.org/attachments/download/2242/RelWithDebInfo.zip))
* Save the dlls in a path that is in the system PATH variable and change the librtl variable in NAdefs.dyalog

To receive data from the RTL device, you can use this command:

samples←¯128+8 u.uns GetSamples (frequency samplerate time)

"frequency" is the frequency in Hz
"samplerate" is the samplerate in samples per second
"time" is measured in seconds

"¯128+8 u.uns" is optional, used to convert the raw output from signed integers to unsigned and center the values around zero.

The 4 provided scripts, used for a live demo at the Dyalog User Meeting 2017, can be used as examples to decode the signal.
Changing the "If 0" to an "If 1" at the beginning of the scripts will make the script itself use the RTL device
instead of the pre-recorded file, provided as well in this project.
