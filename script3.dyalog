 script3;f_bw;Fs;dec_rate;Fs_new;complex;x5;b;tn;samples;time;sr;freq;samp_c;fourier;center;samp_d
 ⍝ DEMO #3 for the Dyalog User Meeting 2017

 ⎕CY'RainPro'
 freq←95800000
 sr←1140000    ⍝ samplerate(Hz)
 time←5        ⍝ time(s)
 fourier←{w←sr÷1000 ⋄ (⌊w÷2)⌽|u.Fourier w↑⍵}
 center←{((freq÷1000)+(⍳≢⍵)-⌊2÷⍨≢⍵)⍵}

 :If 0
     samples←¯128+8 u.uns GetSamples freq sr time
 :Else
     tn←'oksign95.8mhz5sec_speech.cpt'⎕NTIE 0
     samples←¯128+8 u.uns ⎕NREAD tn 83,⎕NSIZE tn
     ⎕NUNTIE tn
 :EndIf

 ⍝ create complex signal
 samp_c←Raw2Complex samples
 View 0 gr.rplot center fourier samp_c

 f_bw←140000
 Fs←sr
 dec_rate←⌊Fs÷f_bw
 Fs_new←Fs÷dec_rate

 samp_c←u.lpassfilt samp_c(u.CalcB f_bw Fs)(⊃samp_c)    ⍝ lowpass filter
 samp_c←((≢samp_c)⍴dec_rate↑1)/samp_c                   ⍝ resampling

 samp_d←12○(1↓samp_c)×(+¯1↓samp_c)                      ⍝ FM demodulation

 f_bw←44100 ⍝ audio
 Fs←Fs_new
 dec_rate←⌊Fs÷f_bw
 Fs_new←Fs÷dec_rate

 samp_d←u.lpassfilt samp_d(u.CalcB f_bw Fs)(⊃samp_d)    ⍝ lowpass filter
 samp_d←((≢samp_d)⍴dec_rate↑1)/samp_d                   ⍝ resampling

 View gr.rplot 10000↑samp_d                             ⍝ DC offset
 samp_d-←(+/÷≢)samp_d
 View gr.rplot 10000↑samp_d

 samp_d sndx.PlaySound 16,⍨⌊Fs_new                      ⍝ Play 16 bit sound
