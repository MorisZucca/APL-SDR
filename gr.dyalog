:Namespace gr

    ∇ {PG}←{larg}rplot data;PG;xint;yint 
      ⍝ Graphic function to be used with RainPro 
      ⍝ rplot data ===> will plot data with x containing just indexing
      ⍝ rplot (x data) ===> will plot data vs x
      :If 1=≡data
          data←(⍳≢data)(data)
      :EndIf
      :If 2=≡data
          data←⍉↑data
      :EndIf
      :If 0=⎕NC'larg'
          larg←0 0
      :EndIf
      :If larg≡0
          larg←⌊⌿data
      :EndIf
      xint yint←larg
      #.ch.Set¨('Xint'xint)('Yint'yint)('XYPLOT,GRID')
      #.ch.Plot data
      PG←#.ch.Close
    ∇


    ∇ {PG}←rsplot data;∆Y;∆X
      ⍝ Graphic function to be used with RainPro 
      :If 1=≡data
          data←(data)(⍳≢data)
      :EndIf
      ∆Y ∆X←data
      #.ch.Set('STYLE' 'MODEL,ANNOTATE,MARKERS,NOLINES,GRID,BOXED,FRAMED')('MB' 48)('ML' 48)('MR' 60)
      #.ch.Set('MARKER' 3 2 1)('COLOUR' 1 2 6) ⍝ DIAMOND, PLUS, Cross
      #.ch.Set('grid' 'NE,solid,fine')('bgcol' 'green,1')
      #.ch.Scatter ∆Y vs ∆X
      PG←#.ch.Close
    ∇

    ∇ r←y vs x
      r←y
      :If 2=⍴,x
      :AndIf 1<|≡x
          #.ch.Set('XV'(1⊃x))('YV'(2⊃x))
      :Else
          #.ch.Set'XV'x
      :End
    ∇

    ∇ {PG}←{log}specgram args;data;n;rho;i;h;split;out;BM;max;wnd;ldata;scaleto;colors;val
    ⍝ args ==> (data n)  ⍝ data, frames to split (ie. 256)
    ⍝ log  ==> 1 if log scale (default 0)
      :If 0=⎕NC'log'
          log←0
      :EndIf
     
      data wnd←args
      rho←≢data
      rho←⌊rho÷wnd
      data←↓(rho,wnd)⍴data
      data←|¨##.u.Fourier¨data
      data←(⌊wnd÷2)↑¨data   ⍝ simmetry
      data←⍉↑data
      data←(⌊2÷⍨≢data)⊖data
      :If log
          ldata←⍟data+1E¯7  ⍝ log scale?
          max←2⌈⌈/,ldata ⋄ ldata←ldata÷max÷255
          data←ldata
      :EndIf
     
      scaleto←16
      max←2⌈⌈/,data ⋄ data←data÷max÷scaleto
      data←0⌈⌊data
      colors←#.gr.jetcolors ⍝ jet color scheme
      :If scaleto<≢colors
          colors←⌊colors[1++\0,((⌊(≢colors)÷scaleto)-1)⍴scaleto;]
      :EndIf
     
      'BM'⎕WC'Bitmap'('Bits'data)('CMap'colors)
      'FF'⎕WC'Form'('Picture'BM 2)
      ⍝⎕DQ FF
    ∇

    ∇ colors←jetcolors;r;g;b;i;n
      r g b←⊂256⍴0
      :For i :In 0,⍳255
          n←4×i÷256
          r[i+1]←255×1⌊0⌈(n-1.5)⌊(4.5-n)
          g[i+1]←255×1⌊0⌈(n-0.5)⌊(3.5-n)
          b[i+1]←255×1⌊0⌈(n+0.5)⌊(2.5-n)
      :EndFor
      colors←r,g,[1.1]b
    ∇

    ∇ {PG}←powerdist args;data;wnd;rho;PG
      ⍝ Graphic functions to be used with RainPro 
     
      data wnd←args
      rho←≢data
      rho←⌊rho÷wnd
      data←↓(rho,wnd)⍴data    
      data←wnd∘{⍟(⌊⍺÷2)↑|##.u.Fourier ⍺↑⍵}¨data
      PG←0 ##.gr.rplot (⊃+/data)
    ∇





:EndNamespace
