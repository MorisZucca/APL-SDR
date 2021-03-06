﻿:Namespace u
⍝ alternative functions' names for Dyalog Classic Edition
⍝ ⊆     Nest: Enclose Underscore
⍝ ⌸     Key: Quad Equals
⍝ ⌺     Stencil: Quad Diamond
⍝ ⍠     Variant: Quad Colon (you can also use ⎕OPT)
⍝ ⍤     Rank: Jot Diaresis
⍝ ⍸     Where: Iota Underscore


    ∇ CopyToClip arg
      :If 0=⎕NC'clip'
          'clip'⎕WC'Clipboard'
      :EndIf
      clip.Array←arg
    ∇

    Fourier←{⍺←1 ⋄ ⍵ RunFn 'idft' 'dft'⊃⍨1+0⌈⍺}
    ∇ data←data RunFn func;rank;shape;count ⍝ n-D Discrete Fourier Transformation
      (rank count)←(⍴,×/)shape←⍴data
      :If 1<count ⍝ non-scalar
          :If 3≠⎕NC func ⍝ associate external function if it does not exist
              ⎕NA'fftw|',func,'<I4 <I4[] =J16[]'
          :EndIf
          data←(count*0.5)÷⍨shape⍴(⍎func)rank shape,⊂∊data ⍝ Normalized Fourier/Inverse Fourier transform
      :EndIf
    ∇

    ∇ real←Real complex
      real←9○complex
    ∇

    ∇ imag←Imag complex
      imag←11○complex
    ∇

    ∇ out←lpassfilt args;s;b;fv
      ⍝ args ==> Signal, Beta, FirstVal
      ⍝ out ==> SmoothSignal
      s b fv←args
      out←,⍬⍴fv
      {out,←(b×⍵)+(¯1↑out)×1-b}¨1↓s
    ∇

    ∇ out←lpassfilt_array args;s;b
      s b←args
      out←b×(b∘{(¯1↓⍵)+(1-⍺)×(1↓⍵)}⍣20)s
    ∇

    ∇ b←CalcB args;rc;cutoff;samplerate;dt
      ⍝ args ==> cutoff, samplerate,
      ⍝ https://stackoverflow.com/questions/13882038/implementing-simple-high-and-low-pass-filters-in-c
      cutoff samplerate←args
      rc←÷cutoff×2×3.141592
      dt←÷samplerate
      b←dt÷rc+dt
    ∇

      uns←{        ⍝ Unsigned from signed integer.
          (2*⍺)|⍵
      }

      int←{        ⍝ Signed from unsigned integer.
          ↑⍵{(⍺|⍺⍺+⍵)-⍵}/2*⍺-0 1
      }


:EndNamespace
