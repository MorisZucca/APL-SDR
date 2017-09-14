:Namespace sndx
⍝ Functions to play arbitrary sounds in MS Windows  
⍝ by github.com/lstefano71

    ∇ {r}←ctl PlaySound(srate bits);buf;_;play;smp;tou;samples;max;nchan
     
      :With _←⎕NS''
          SND_SYNC←0
          SND_ASYNC←1
          SND_NODEFAULT←2
          SND_MEMORY←4
          SND_LOOP←8
          SND_NOSTOP←16
          c←{2⊥∨/(32⍴2)⊤⍵}
      :EndWith
     
      tou←{
          n←⍎'3',⍨⍕bits
          256|83 ⎕DR⊃((⎕DR ⍵),n)⎕DR ⍵
      }
     
      :If 1≡≡ctl
          samples←ctl
          max←⌈/|samples
      :Else
          samples max←ctl
      :EndIf
     
      nchan←1
      :If 2=⍴⍴samples
          nchan←⊃⌽⍴samples
          samples←,samples
      :EndIf
     
      smp←tou{
          ⎕DIV←1
          {(×⍵)×⌊0.5+|⍵}(¯1+2*bits-1)×⍵÷max
      }samples
     
     
      buf←smp Hdr srate nchan bits
      buf,←smp
     
      'play'⎕NA'I winmm|sndPlaySound* <U1[] U4'
      r←play buf _.(c SND_SYNC SND_MEMORY)
    ∇




    ∇ r←d(srate Haas)sam;n
     
      :If 1=⍴⍴sam
          sam←sam,[1.5]sam
      :EndIf
     
      n←⌊srate×d
      sam←(n+≢sam)↑[1]sam
      r←(0,-n)⊖sam
    ∇


    ∇ r←samples Hdr(srate nchan bits);text;num;n32;n16;s
      text←{0=⎕NC'⍺':⎕UCS ⍵ ⋄ ⍺ ⎕UCS ⍵}
      num←{⌽((⍺÷8)⍴256)⊤(256*⍺÷8)|⍵}
      n32←32∘num
      n16←16∘num
      s←{z←⍺ ⋄ z[⍺⍺+⍳⍴⍵]←⍵ ⋄ z}
     
      r←⍬
      r,←text'RIFF'
      r,←n32 0
      r,←text'WAVE'
      r,←text'fmt '
      r,←n32 16
      r,←n16 1
      r,←n16 nchan
      r,←n32 srate
      r,←n32 srate nchan bits×.÷1 1 8
      r,←n16 nchan bits×.÷1 8
      r,←n16 bits
      r,←text'data'
      r,←n32(≢samples)nchan bits×.÷1 1 8
     
      r(4 s)←n32 ¯8++/≢¨samples r
      r(40 s)←n32 ¯44++/≢¨samples r
    ∇



:EndNamespace
