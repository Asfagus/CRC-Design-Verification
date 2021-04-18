# CRC Design Verification

**IEEE 802.3 crc 32 code generator**


IEEE 802.3 crc32 Hardware Implementation could be found in: https://www.xilinx.com/support/documentation/application_notes/xapp209.pdf

Here is an example for input data (10 byte in hex) with look up table method: 0a 0c 0e 10 12 14 16 18 1a 1c 
IEEE 802.3 crc32 Normal polynomial (hex)used:0x04C11DB7

![alt text](https://github.com/Asfagus/CRC-Design-Verification/blob/main/crc32.png)

<ul>
<li> Only until your whole data byte (in this case 10 bytes total) ends, then you xor the New crc register with 0xffff_ffff to get the crc value output. Otherwise, you only update your crc register with the column "Current CRC value". I xor the New crc register with 0xffff_ffff at the end of each line so I can check my manual calculation using the website below to see what if I send 1 byte only, 2 byte only, 3 byte only...... or 10 byte data.</li>
<li> Current crc value update using equation below:

New crc value = (Looktable[new index])^ (current crc value >>8) </li>

In this case, the result crc_value is 0x78dd_4b9a. Then we use little endian to transmit the crc32 code, so that the LSB goes along with the data first: 0a 0c 0e 10 12 14 16 18 1a 1c 9a 4b dd 78
</ul>

**Check the result using this website**


http://www.sunshine2k.de/coding/javascript/crc/crc_js.html

Check these boxes as indicate below to use the IEEE 802.3 crc32 to get the correct crc code to attach to your data
![alt text](https://github.com/Asfagus/CRC-Design-Verification/blob/main/crc32_websitechecker_example.png)

**IEEE 802.3 crc 32 look up table with 256 cases:**

Lookup table

    index
<ul>  0-5	  0x00000000U, 0x77073096U, 0xee0e612cU, 0x990951baU, 0x076dc419U, 0x706af48fU,</ul>
<ul>  6-11    0xe963a535U, 0x9e6495a3U, 0x0edb8832U, 0x79dcb8a4U, 0xe0d5e91eU, 0x97d2d988U,</ul>
<ul>  12      0x09b64c2bU, 0x7eb17cbdU, 0xe7b82d07U, 0x90bf1d91U, 0x1db71064U, 0x6ab020f2U,</ul>
<ul>  18      0xf3b97148U, 0x84be41deU, 0x1adad47dU, 0x6ddde4ebU, 0xf4d4b551U, 0x83d385c7U,</ul>
<ul>  24      0x136c9856U, 0x646ba8c0U, 0xfd62f97aU, 0x8a65c9ecU, 0x14015c4fU, 0x63066cd9U,</ul>
<ul>  30      0xfa0f3d63U, 0x8d080df5U, 0x3b6e20c8U, 0x4c69105eU, 0xd56041e4U, 0xa2677172U,</ul>
<ul>  36      0x3c03e4d1U, 0x4b04d447U, 0xd20d85fdU, 0xa50ab56bU, 0x35b5a8faU, 0x42b2986cU,</ul>
<ul>  42      0xdbbbc9d6U, 0xacbcf940U, 0x32d86ce3U, 0x45df5c75U, 0xdcd60dcfU, 0xabd13d59U,</ul>
<ul>  48      0x26d930acU, 0x51de003aU, 0xc8d75180U, 0xbfd06116U, 0x21b4f4b5U, 0x56b3c423U,</ul>
<ul>  54      0xcfba9599U, 0xb8bda50fU, 0x2802b89eU, 0x5f058808U, 0xc60cd9b2U, 0xb10be924U,</ul>
<ul>  60      0x2f6f7c87U, 0x58684c11U, 0xc1611dabU, 0xb6662d3dU, 0x76dc4190U, 0x01db7106U,</ul>
<ul>  66      0x98d220bcU, 0xefd5102aU, 0x71b18589U, 0x06b6b51fU, 0x9fbfe4a5U, 0xe8b8d433U,</ul>
<ul>  72      0x7807c9a2U, 0x0f00f934U, 0x9609a88eU, 0xe10e9818U, 0x7f6a0dbbU, 0x086d3d2dU,</ul>
<ul>  78      0x91646c97U, 0xe6635c01U, 0x6b6b51f4U, 0x1c6c6162U, 0x856530d8U, 0xf262004eU,</ul>
<ul>  84      0x6c0695edU, 0x1b01a57bU, 0x8208f4c1U, 0xf50fc457U, 0x65b0d9c6U, 0x12b7e950U,</ul>
<ul>  90      0x8bbeb8eaU, 0xfcb9887cU, 0x62dd1ddfU, 0x15da2d49U, 0x8cd37cf3U, 0xfbd44c65U,</ul>
<ul>  96      0x4db26158U, 0x3ab551ceU, 0xa3bc0074U, 0xd4bb30e2U, 0x4adfa541U, 0x3dd895d7U,</ul>
<ul>  102     0xa4d1c46dU, 0xd3d6f4fbU, 0x4369e96aU, 0x346ed9fcU, 0xad678846U, 0xda60b8d0U,</ul>
<ul>  108     0x44042d73U, 0x33031de5U, 0xaa0a4c5fU, 0xdd0d7cc9U, 0x5005713cU, 0x270241aaU,</ul>
<ul>  114     0xbe0b1010U, 0xc90c2086U, 0x5768b525U, 0x206f85b3U, 0xb966d409U, 0xce61e49fU,</ul>
<ul>  120     0x5edef90eU, 0x29d9c998U, 0xb0d09822U, 0xc7d7a8b4U, 0x59b33d17U, 0x2eb40d81U,</ul>
<ul>  126     0xb7bd5c3bU, 0xc0ba6cadU, 0xedb88320U, 0x9abfb3b6U, 0x03b6e20cU, 0x74b1d29aU,</ul>
<ul>  132     0xead54739U, 0x9dd277afU, 0x04db2615U, 0x73dc1683U, 0xe3630b12U, 0x94643b84U,</ul>
<ul>  138     0x0d6d6a3eU, 0x7a6a5aa8U, 0xe40ecf0bU, 0x9309ff9dU, 0x0a00ae27U, 0x7d079eb1U,</ul>
<ul>  144     0xf00f9344U, 0x8708a3d2U, 0x1e01f268U, 0x6906c2feU, 0xf762575dU, 0x806567cbU,</ul>
<ul>  150     0x196c3671U, 0x6e6b06e7U, 0xfed41b76U, 0x89d32be0U, 0x10da7a5aU, 0x67dd4accU,</ul>
<ul>  156     0xf9b9df6fU, 0x8ebeeff9U, 0x17b7be43U, 0x60b08ed5U, 0xd6d6a3e8U, 0xa1d1937eU,</ul>
<ul>  162     0x38d8c2c4U, 0x4fdff252U, 0xd1bb67f1U, 0xa6bc5767U, 0x3fb506ddU, 0x48b2364bU,</ul>
<ul>  168     0xd80d2bdaU, 0xaf0a1b4cU, 0x36034af6U, 0x41047a60U, 0xdf60efc3U, 0xa867df55U,</ul>
<ul>  174     0x316e8eefU, 0x4669be79U, 0xcb61b38cU, 0xbc66831aU, 0x256fd2a0U, 0x5268e236U,</ul>
<ul>  180     0xcc0c7795U, 0xbb0b4703U, 0x220216b9U, 0x5505262fU, 0xc5ba3bbeU, 0xb2bd0b28U,</ul>
<ul>  186     0x2bb45a92U, 0x5cb36a04U, 0xc2d7ffa7U, 0xb5d0cf31U, 0x2cd99e8bU, 0x5bdeae1dU,</ul>
<ul>  192     0x9b64c2b0U, 0xec63f226U, 0x756aa39cU, 0x026d930aU, 0x9c0906a9U, 0xeb0e363fU,</ul>
<ul>  198     0x72076785U, 0x05005713U, 0x95bf4a82U, 0xe2b87a14U, 0x7bb12baeU, 0x0cb61b38U,</ul>
<ul>  204     0x92d28e9bU, 0xe5d5be0dU, 0x7cdcefb7U, 0x0bdbdf21U, 0x86d3d2d4U, 0xf1d4e242U,</ul>
<ul>  210     0x68ddb3f8U, 0x1fda836eU, 0x81be16cdU, 0xf6b9265bU, 0x6fb077e1U, 0x18b74777U,</ul>
<ul>  216     0x88085ae6U, 0xff0f6a70U, 0x66063bcaU, 0x11010b5cU, 0x8f659effU, 0xf862ae69U,</ul>
<ul>  222     0x616bffd3U, 0x166ccf45U, 0xa00ae278U, 0xd70dd2eeU, 0x4e048354U, 0x3903b3c2U,</ul>
<ul>  228     0xa7672661U, 0xd06016f7U, 0x4969474dU, 0x3e6e77dbU, 0xaed16a4aU, 0xd9d65adcU,</ul>
<ul>  234     0x40df0b66U, 0x37d83bf0U, 0xa9bcae53U, 0xdebb9ec5U, 0x47b2cf7fU, 0x30b5ffe9U,</ul>
<ul>  240     0xbdbdf21cU, 0xcabac28aU, 0x53b39330U, 0x24b4a3a6U, 0xbad03605U, 0xcdd70693U,</ul>
<ul>  246     0x54de5729U, 0x23d967bfU, 0xb3667a2eU, 0xc4614ab8U, 0x5d681b02U, 0x2a6f2b94U,</ul>
<ul>  252     0xb40bbe37U, 0xc30c8ea1U, 0x5a05df1bU, 0x2d02ef8dU</ul>

