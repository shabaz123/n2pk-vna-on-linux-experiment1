n2pk-vna-on-linux-experiment1  
=============================  
  
This code is some initial experimentation; an attempt at controlling the attenuator signals on the  
N2PK VNA, using Linux. It is not a complete program! It is for software developers interested in seeing   
how to get going to develop software for the VNA in Linux, for the future.  
  
The hardware was a Raspberry Pi.  
For more information, see the N2PK-VNA Yahoo mailer list.  
  
In brief, to run this code, issue the following:  
  
as root user:  
apt-get update  
apt-get install fxload  
apt-get install libudev-dev  
apt-get install libusb-1.0-0-dev  
  
as normal user (e.g. as pi user) from the user's home directory:  
mkdir -p development  
cd development  
git clone https://github.com/shabaz123/n2pk-vna-on-linux-experiment1.git n2pk  
cd n2pk  
  
Now the code is in the development/n2pk folder. To compile, just type:  
make  
  
If it compiles successfully, you'll just see these two lines appear:  
gcc -c -I /usr/include/libusb-1.0 test.c  
gcc test.o -L. -L/usr/lib/arm-linux-gnueabihf/ -lusb-1.0 -o test  
  
If there is more output, then there could be an error or warning : (  
  
Plug in the N2PK VNA into a USB port on the Pi, and power up the VNA if you've not already done so.  
You can check if the VNA is detected by the Pi, by typing:  
lsusb  
  
You should see several lines of output, but the one you're looking for will contain the text  
"Anchor Chips, Inc."  
If you can see that, then the VNA is successfully connected to the Pi.  
  
To run the program, you need to be root user. As root user, type:  
./test  
  
If the output contains:  
error libusb_open   
then you're likely not running as root user.  
  
If it runs successfully, you'll see this output:  
root@raspberrypi:/home/pi/development/junk/test/n2pk# ./test  
Dev (bus 1, device 5): Cypress - N2PK VNA V5  
Dev (bus 1, device 4): 0424 - 7800  
Dev (bus 1, device 3): 0424 - 2514  
Dev (bus 1, device 2): 0424 - 2514  
Dev (bus 1, device 1): Linux 4.19.42-v7+ dwc_otg_hcd - DWC OTG Controller  
success libusb_open  
  
Interface Descriptors:   
        Number of Interfaces : 1  
        Length : 9  
        Desc_Type : 2  
        Config_index : 0  
        Total length : 32  
        Configuration Value  : 1  
        Configuration Attributes : 160  
        MaxPower(mA) : 250  
  
EndPoint Descriptors:   
        Size of EndPoint Descriptor : 7  
        Type of Descriptor : 5  
        Endpoint Address : 0x086  
        Maximum Packet Size: 200  
        Attributes applied to Endpoint: 2  
        Interval for Polling for data Tranfer : 0  
write success!  
write success!  
write success!  
write success!  
...  
calling libusb_release_interface  
calling libusb_free_device_list  
calling libusb_close  
calling libusb_exit  
  
The write_success lines should repeat 20 times (the code is toggling some of the attenuator signals repeatedly).  
If you want to, you can confirm that the attenuator signal really is toggling, by connecting a multimeter/voltmeter  
to the ATT0 signal (see v5_DDS.pdf, it is on header J702) and GND. It should toggle between 0V and 3.3V.  
  
That's it! This experimental code doesn't do anything else.   
  
