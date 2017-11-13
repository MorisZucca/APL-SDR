 NAdefs;defrtl;u4;c;i;rtlsdr_dev;librtl;prtlsdr_dev;cc;oc
 ⍝ Structure of rtlsdr_dev is in https://github.com/osmocom/rtl-sdr/blob/master/src/librtlsdr.c

 :If 3=⎕NC'rtlsdr_get_device_count'   ⍝ If we've already defined functions, don't repeat all
     :Return
 :EndIf

 librtl←'C:\MPath\rtlsdr.dll'

 u4←'U4'  ⍝ unsigned int 32
 cc←'<0T1' ⍝ const char *char
 i←'I'    ⍝ int
 oc←'>0T1' ⍝ output char (char *char)
 prtlsdr_dev←'>P'
 rtlsdr_dev←'P'
 defrtl←{(⊃⍵)⎕NA ⍺,' ',librtl,'|',⊃,/(⍵,¨⊂' ')}
⍝- typedef struct rtlsdr_dev rtlsdr_dev_t;
⍝- uint32_t rtlsdr_get_device_count(void);
 u4 defrtl'rtlsdr_get_device_count' ''                ⍝ niladic
⍝- const char* rtlsdr_get_device_name(uint32_t index);
 'P'defrtl'rtlsdr_get_device_name'u4                   ⍝ index
⍝- int rtlsdr_get_device_usb_strings(uint32_t index, char *manufact, char *product, char *serial);
 i defrtl'rtlsdr_get_device_usb_strings'u4 oc oc oc  ⍝ index, manufact, product, serial
⍝- int rtlsdr_get_index_by_serial(const char *serial);
 i defrtl'rtlsdr_get_index_by_serial'cc               ⍝ serial
⍝- int rtlsdr_open(rtlsdr_dev_t **dev, uint32_t index);
 i defrtl'rtlsdr_open'prtlsdr_dev u4                   ⍝ device, index
⍝- int rtlsdr_close(rtlsdr_dev_t *dev);
 i defrtl'rtlsdr_close'rtlsdr_dev                     ⍝ device
⍝- int rtlsdr_set_xtal_freq(rtlsdr_dev_t *dev, uint32_t rtl_freq, uint32_t tuner_freq);
 i defrtl'rtlsdr_set_xtal_freq'rtlsdr_dev u4 u4       ⍝ device, rtl_freq, tuner_freq
⍝- int rtlsdr_get_xtal_freq(rtlsdr_dev_t *dev, uint32_t *rtl_freq, uint32_t *tuner_freq);
 i defrtl'rtlsdr_get_xtal_freq'rtlsdr_dev'>U4 >U4'
⍝- int rtlsdr_get_usb_strings(rtlsdr_dev_t *dev, char *manufact, char *product, char *serial);
 i defrtl'rtlsdr_get_usb_strings'rtlsdr_dev oc oc oc ⍝ dev, manufact, product, serial
⍝- int rtlsdr_write_eeprom(rtlsdr_dev_t *dev, uint8_t *data, uint8_t offset, uint16_t len);
 i defrtl'rtlsdr_write_eeprom'rtlsdr_dev'>U1 U1 U2'
⍝- int rtlsdr_read_eeprom(rtlsdr_dev_t *dev, uint8_t *data, uint8_t offset, uint16_t len);
 i defrtl'rtlsdr_read_eeprom'rtlsdr_dev'<U1 U1 U2'
⍝- int rtlsdr_set_center_freq(rtlsdr_dev_t *dev, uint32_t freq);
 i defrtl'rtlsdr_set_center_freq'rtlsdr_dev u4
⍝- uint32_t rtlsdr_get_center_freq(rtlsdr_dev_t *dev);
 u4 defrtl'rtlsdr_get_center_freq'rtlsdr_dev
⍝ int rtlsdr_set_freq_correction(rtlsdr_dev_t *dev, int ppm);
 i defrtl'rtlsdr_set_freq_correction'rtlsdr_dev i
⍝ int rtlsdr_get_freq_correction(rtlsdr_dev_t *dev);
 i defrtl'rtlsdr_get_freq_correction'rtlsdr_dev
⍝enum rtlsdr_tuner {
⍝    RTLSDR_TUNER_UNKNOWN = 0,
⍝    RTLSDR_TUNER_E4000,
⍝    RTLSDR_TUNER_FC0012,
⍝    RTLSDR_TUNER_FC0013,
⍝    RTLSDR_TUNER_FC2580,
⍝    RTLSDR_TUNER_R820T,
⍝    RTLSDR_TUNER_R828D
⍝};
 enum_rtlsdr_tuner←'RTLSDR_TUNER_UNKNOWN' 'RTLSDR_TUNER_E4000' 'RTLSDR_TUNER_FC0012' 'RTLSDR_TUNER_FC0013' 'RTLSDR_TUNER_FC2580' 'RTLSDR_TUNER_R820T' 'RTLSDR_TUNER_R828D'
⍝ enum rtlsdr_tuner rtlsdr_get_tuner_type(rtlsdr_dev_t *dev);
 i defrtl'rtlsdr_get_tuner_type'rtlsdr_dev
⍝ int rtlsdr_get_tuner_gains(rtlsdr_dev_t *dev, int *gains);
 i defrtl'rtlsdr_get_tuner_gains'rtlsdr_dev'>I[]'
⍝ int rtlsdr_set_tuner_gain(rtlsdr_dev_t *dev, int gain);
 i defrtl'rtlsdr_set_tuner_gain'rtlsdr_dev i
⍝ int rtlsdr_set_tuner_bandwidth(rtlsdr_dev_t *dev, uint32_t bw);
⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝ i defrtl'rtlsdr_set_tuner_bandwidth'rtlsdr_dev u4
⍝ int rtlsdr_get_tuner_gain(rtlsdr_dev_t *dev);
 i defrtl'rtlsdr_get_tuner_gain'rtlsdr_dev
⍝ int rtlsdr_set_tuner_if_gain(rtlsdr_dev_t *dev, int stage, int gain);
 i defrtl'rtlsdr_set_tuner_if_gain'rtlsdr_dev i i
⍝ int rtlsdr_set_tuner_gain_mode(rtlsdr_dev_t *dev, int manual);
 i defrtl'rtlsdr_set_tuner_gain_mode'rtlsdr_dev i
⍝ int rtlsdr_set_sample_rate(rtlsdr_dev_t *dev, uint32_t rate);
 i defrtl'rtlsdr_set_sample_rate'rtlsdr_dev u4
⍝ uint32_t rtlsdr_get_sample_rate(rtlsdr_dev_t *dev);
 u4 defrtl'rtlsdr_get_sample_rate'rtlsdr_dev
⍝ int rtlsdr_set_testmode(rtlsdr_dev_t *dev, int on);
 i defrtl'rtlsdr_set_testmode'rtlsdr_dev'>I'
⍝ int rtlsdr_set_agc_mode(rtlsdr_dev_t *dev, int on);
 i defrtl'rtlsdr_set_agc_mode'rtlsdr_dev i
⍝ int rtlsdr_set_direct_sampling(rtlsdr_dev_t *dev, int on);
 i defrtl'rtlsdr_set_direct_sampling'rtlsdr_dev i
⍝ int rtlsdr_get_direct_sampling(rtlsdr_dev_t *dev);
 i defrtl'rtlsdr_get_direct_sampling'rtlsdr_dev
⍝ int rtlsdr_set_offset_tuning(rtlsdr_dev_t *dev, int on);
⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝ i defrtl'rtlsdr_set_direct_tuning'rtlsdr_dev i
⍝ int rtlsdr_get_offset_tuning(rtlsdr_dev_t *dev);
 i defrtl'rtlsdr_get_offset_tuning'rtlsdr_dev
⍝ int rtlsdr_reset_buffer(rtlsdr_dev_t *dev);
 i defrtl'rtlsdr_reset_buffer'rtlsdr_dev
⍝ int rtlsdr_read_sync(rtlsdr_dev_t *dev, void *buf, int len, int *n_read);
 i defrtl'rtlsdr_read_sync'rtlsdr_dev'>I1[] I >I'

⍝ typedef void(*rtlsdr_read_async_cb_t)(unsigned char *buf, uint32_t len, void *ctx);
⍝ int rtlsdr_wait_async(rtlsdr_dev_t *dev, rtlsdr_read_async_cb_t cb, void *ctx);
⍝ int rtlsdr_read_async(rtlsdr_dev_t *dev, rtlsdr_read_async_cb_t cb, void *ctx, uint32_t buf_num, uint32_t buf_len);
⍝ int rtlsdr_cancel_async(rtlsdr_dev_t *dev);
⍝ int rtlsdr_set_bias_tee(rtlsdr_dev_t *dev, int on);
