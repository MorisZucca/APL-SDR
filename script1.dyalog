 script1;gains;r;z;ttype;dev_freq;new_freq;buf;len;out;device
 ⍝ DEMO #1 for the Dyalog User Meeting 2017

 device←Init
 :If device≡¯1
     ⎕←'Couldn''t load any device... exiting'
     :Return
 :EndIf

 z←rtlsdr_get_tuner_type device
 r ttype←z
 :If r<0
     ⎕←'Failed to read tuner type'
     ∘∘∘
 :EndIf
 ⎕←'Tuner type is: ',⍕enum_rtlsdr_tuner[⎕IO+ttype]

 ⎕←dev_freq←rtlsdr_get_center_freq device   ⍝
 new_freq←102500000                         ⍝
 r←rtlsdr_set_center_freq(device new_freq)  ⍝ frequency in Hz
 ⎕←rtlsdr_get_center_freq device

 z←rtlsdr_get_tuner_gains(device 1024)
 r gains←z
 :If r<0
     ⎕←'Failed to read gains'
     ∘∘∘
 :EndIf
 ⎕←gains←r↑gains

 r←rtlsdr_set_tuner_gain_mode device 1  ⍝ set gain mode to manual
 r←rtlsdr_set_tuner_gain device 364     ⍝ 36.4 dB
 ⎕←rtlsdr_get_tuner_gain device

 ⍝ always start with a buffer reset, then read!
 z←rtlsdr_reset_buffer device

 z←rtlsdr_read_sync device 262144 262144 0
 r buf len←z
 out←¯128+8 u.uns len↑buf
 ⎕←'Reading response: ',⍕r
 ⎕←'Buffer length: ',⍕len
 ⎕←100↑out
 z←rtlsdr_close device

 ⎕OFF
