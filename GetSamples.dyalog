 samples←{device}GetSamples argx;r;z;dev_freq;dev_ind;buf;len;out;new_freq;i;vendor;product;serial;num_of_dev;gains;ttype;out_norm;device;sample_rate;sample_num;freq;TUNE_AUTO;TUNE_MANUAL;MAX_NO_GAINS;BUF_SIZE;BUF_NUM;BUF_SKIP;BYTES_PER_SAMPLE;tot_read;GAIN
 ⍝ Quick howto: Record 5 seconds at frequency 102.5 MHz and samplerate 1140ksps
 ⍝ samples←GetSamples 102500000 1140000 5

 freq sample_rate sample_num←argx
 :If 0=⎕NC'device'
     device←Init
     :If ¯1≡device
         samples←⍬
         ⎕←'No device connected... exiting'
         :Return
     :EndIf
 :EndIf

 ⍝ globals' definitions
 TUNE_AUTO←0
 TUNE_MANUAL←1
 BUF_SIZE←16×32×512
 BYTES_PER_SAMPLE←2  ⍝ rtl device delivers 8 bit unsigned IQ data
 GAIN←364

 z←rtlsdr_get_tuner_gains(device 1024)
 r gains←z
 :If r<0
     ⎕←'Oops: failed to read gains'
     ∘∘∘
 :EndIf
 gains←r↑gains
 :If ~GAIN∊gains
     ⎕←'Oops: chosen gain is not available for this device'
     ∘∘∘
 :EndIf

 r←rtlsdr_set_center_freq(device freq)      ⍝ frequency in Hz

 :If 0
     r←rtlsdr_set_tuner_gain_mode device TUNE_AUTO
 :Else
     r←rtlsdr_set_tuner_gain_mode device TUNE_MANUAL
     r←rtlsdr_set_tuner_gain device GAIN   ⍝ 36.4 dB
 :EndIf

 r←rtlsdr_set_sample_rate(device sample_rate)

 ⍝ always start with a buffer reset, then read!
 z←rtlsdr_reset_buffer device

 samples←⍬
 tot_read←×/2 sample_rate sample_num
 :Repeat
     z←rtlsdr_read_sync device BUF_SIZE BUF_SIZE 0
     r buf len←z
     out←len↑buf
     samples,←out
     ⍞←'*'
 :Until tot_read<≢samples

 ⍝ Closing the device
 z←rtlsdr_close device
