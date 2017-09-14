 script4;freq;sr;time;samples;samp_c;signal;tn;filtered;filtered2;filtered3;section;OUT;fourier;center
 ⍝ DEMO #4 for the Dyalog User Meeting 2017

 ⎕CY'RainPro'
 freq←868250000 ⍝ frequency(Hz)
 sr←1140000     ⍝ samplerate(Hz)
 time←2         ⍝ time(s)
 fourier←{w←sr÷1000 ⋄ (⌊w÷2)⌽|u.Fourier w↑⍵}
 center←{((freq÷1000)+(⍳≢⍵)-⌊2÷⍨≢⍵)⍵}

 :If 0
     samples←¯128+8 u.uns GetSamples freq sr time
 :Else
     tn←'garage_2s.cpt'⎕NTIE 0
     samples←¯128+8 u.uns ⎕NREAD tn 83,⎕NSIZE tn
     ⎕NUNTIE tn
 :EndIf

 ⎕←≢samples
 samp_c←Raw2Complex samples
 ⎕←≢samp_c

 #.View #.gr.rplot 5000↑1400000↓9○samp_c    ⍝ plot of just the I part of the signal

 ⍝ AM demodulation means we're interested in the magnitude of the signal
 signal←|samp_c

 ⍝#.View #.gr.rplot 700000↑700000↓signal ⍝ general signal start
 #.View #.gr.rplot 1400000↑700000↓signal ⍝ whole signal

 ⍝ zoom in at the signal region -> "OOK"
 ⍝ #.View #.gr.rplot 10000↑1400000↓signal  ⍝ 01001001101001001001101001001001
 #.View #.gr.rplot 20000↑1190000↓signal

 ⍝ #.View #.gr.rplot 100<10000↑1400000↓signal
 #.View #.gr.rplot 100<20000↑1190000↓signal       ⍝ count signals:15
 ⎕←≢{⎕ML←3 ⋄ ⍵⊂⍵}100<20000↑1190000↓signal         ⍝ ⍵⊂⍵ -> 15 groups
 ⎕←≢¨{⎕ML←3 ⋄ ⍵⊂⍵}100<20000↑1190000↓signal        ⍝ count lengths of groups
 ⎕←{⍵/1 0⍴⍨≢⍵}⌊0.5+295÷⍨¯1↓{≢¨⍵⊂⍨2≠/⍵,0}100<20000↑1190000↓signal   ⍝ bits representation of signal
 ⍝ )ed 'OUT'  ---> full signal
 OUT←{⍵/1 0⍴⍨≢⍵}⌊0.5+295÷⍨¯1↓{≢¨⍵⊂⍨2≠/⍵,0}100<900000↑1190000↓signal

 ⍝ what's the difference between unfiltered and filtered?
 section←3000↑1400000↓signal
 filtered←#.u.lpassfilt section(#.u.CalcB 30000 1140000)(⊃section)
 filtered2←#.u.lpassfilt section(#.u.CalcB 10000 1140000)(⊃section)
 filtered3←#.u.lpassfilt section(#.u.CalcB 1000 1140000)(⊃section)
 #.View #.gr.rplot section,filtered,filtered2,filtered3
