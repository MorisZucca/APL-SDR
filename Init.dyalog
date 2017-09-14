 device←Init;r;z;dev_freq;dev_ind;buf;len;out;new_freq;i;vendor;product;serial;num_of_dev;gains;ttype;out_norm

 NAdefs ⍝ definition of rtlsdr.dll's functions
 device←¯1
 ⎕←'# of devices: ',⍕num_of_dev←rtlsdr_get_device_count

 :If 0=num_of_dev
     ⎕←'No device... exiting'
     :Return
 :EndIf
 ⎕←'------------------------------------'
 dev_ind←¯1
 :For i :In ¯1+⍳num_of_dev
     z←rtlsdr_get_device_usb_strings i 256 256 256
     r vendor product serial←z
     ⎕←'Device #',(⍕i),':'
     ⎕←'Vendor: ',⍕vendor
     ⎕←'Product: ',⍕product
     ⎕←'Serial: ',⍕serial
     ⎕←'------------------------------------'
     :If (↓product)∊'RTL2832U' 'RTL2838UHIDIR'
         dev_ind←i
     :EndIf
 :EndFor
 :If 0>dev_ind
     ⎕←'No compatible device, exiting'
     :Return
 :Else
     ⎕←'Chosen device: #',⍕dev_ind
 :EndIf

 z←rtlsdr_open 0 dev_ind
 r device←z
 :If r<0
     ⎕←'Oops: failed to open device'
     ∘∘∘
 :EndIf
