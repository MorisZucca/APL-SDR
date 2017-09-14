 TestDevice device;r;z;dev_freq;dev_ind;buf;len;out;new_freq;i;vendor;product;serial;num_of_dev;gains;ttype;out_norm;device;TUNE_AUTO;TUNE_MANUAL;MAX_NO_GAINS;BUF_SIZE;BUF_NUM;BUF_SKIP;BYTES_PER_SAMPLE;dev_freq2

 :If device≡⍬
     device←Init
     :If device≡¯1
         ⎕←'Couldn''t load any device... exiting'
         :Return
     :EndIf
 :EndIf

 TUNE_AUTO←0
 TUNE_MANUAL←1
 BUF_SIZE←16×32×512
 BYTES_PER_SAMPLE←2  ⍝ rtl device delivers 8 bit unsigned IQ data

 z←rtlsdr_get_tuner_gains(device 1024)
 r gains←z
 :If r<0
     ⎕←'Failed to read gains'
     ∘∘∘
 :EndIf
 gains←r↑gains

 z←rtlsdr_get_tuner_type device
 r ttype←z
 :If r<0
     ⎕←'Failed to read tuner type'
     ∘∘∘
 :EndIf
 ⎕←'Tuner type is: ',⍕enum_rtlsdr_tuner[⎕IO+ttype]

 dev_freq←rtlsdr_get_center_freq device     ⍝
 new_freq←102500000                         ⍝
 r←rtlsdr_set_center_freq(device new_freq)  ⍝ frequency in Hz
 dev_freq2←rtlsdr_get_center_freq device     ⍝
 :If dev_freq2≢new_freq
     ⎕←'Oops: failed to set frequency'
     ∘∘∘
 :EndIf

 r←rtlsdr_set_tuner_gain_mode device TUNE_AUTO

 ⍝ always start with a buffer reset, then read!
 z←rtlsdr_reset_buffer device
 z←rtlsdr_read_sync device BUF_SIZE BUF_SIZE 0
 r buf len←z
 out←len↑buf
 ⎕←'Reading response: ',⍕r
 ⎕←'Buffer length: ',⍕len
 z←rtlsdr_close device
