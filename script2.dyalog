 script2;signal;samples;tn;freq;sr;time;samp_c;num;move;new_sr;dec_rate;samp_c_f;fourier;center
 ⍝ DEMO #2 for the Dyalog User Meeting 2017

 ⎕CY'RainPro'
 freq←90500000 ⍝ frequency(Hz)
 sr←1140000    ⍝ samplerate(Hz)
 time←5        ⍝ time(s)
 fourier←{w←sr÷1000 ⋄ (⌊w÷2)⌽|u.Fourier w↑⍵}
 center←{((freq÷1000)+(⍳≢⍵)-⌊2÷⍨≢⍵)⍵}

 :If 0
     samples←¯128+8 u.uns GetSamples freq sr time
 :Else
     tn←'oksign90.5mhz5sec.cpt'⎕NTIE 0
     samples←¯128+8 u.uns ⎕NREAD tn 83,⎕NSIZE tn
     ⎕NUNTIE tn
 :EndIf
 samp_c←Raw2Complex samples

 ⍝ Frequency distribution of the signals
 View 0 gr.rplot center fourier samp_c

 ⍝ Signal over time
 1 gr.specgram samples 2048

 ⍝ move signal by 160kHz
 move←¯160000
 samp_c←{⍵×*(0J¯1)×2×(○1)×(⍳⍴⍵)×move÷1140000}samp_c
 View 0 gr.rplot center fourier samp_c
 move←160000
 samp_c←{⍵×*(0J¯1)×2×(○1)×(⍳⍴⍵)×move÷1140000}samp_c
 View 0 gr.rplot center fourier samp_c  ⍝ keep it open to see it after filtering

 ⍝ filtering
 samp_c_f←u.lpassfilt(10000↑samp_c)(u.CalcB 100000 sr)(⊃samp_c)
 plot←(fourier samp_c),fourier samp_c_f
 View 0 gr.rplot plot

 ⍝ downsampling to 200kHz
 new_sr←200000
 dec_rate←⌊sr÷new_sr
 ⎕←new_sr←sr÷dec_rate
 samp_c_f←((⍴samp_c_f)⍴(dec_rate↑1))/samp_c_f                 ⍝ resampling
 View 0 gr.rplot center fourier samp_c_f

 ⎕OFF
