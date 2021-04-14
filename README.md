# CRC Design Verification

**IEEE 802.3 crc 32**
<ul>
IEEE 802.3 crc32 Hardware Implementation could be found in: https://www.xilinx.com/support/documentation/application_notes/xapp209.pdf

Here is an example for input data (10 byte in hex) with look up table method: 0a 0c 0e 10 12 14 16 18 1a 1c 

![alt text](https://github.com/Asfagus/CRC-Design-Verification/blob/main/crc32.png)

<ul>
<li> Only until your whole data byte (in this case 10 bytes total) ends, then you xor the crc register with 0xffff_ffff to get the crc value output.Otherwise, you only update your crc register with the column "Current CRC value".</li>
<li> Current crc value update using equation below:
current crc value = (Looktable[new index])^ (current crc value >>8) </li>

In this case, the result crc_value is 0x78dd_4b9a. Then we use little endian to transmit the crc32 code, so that the LSB goes along with the data first: 0a 0c 0e 10 12 14 16 18 1a 1c 9a 4b dd 78
</ul>

**Check use this website**
<ul>
http://www.sunshine2k.de/coding/javascript/crc/crc_js.html

Check these boxes as indicate below to use the IEEE 802.3 crc32 to get the correct crc code to attach to your data
![alt text](https://github.com/Asfagus/CRC-Design-Verification/blob/main/crc32_websitechecker_example.png)
