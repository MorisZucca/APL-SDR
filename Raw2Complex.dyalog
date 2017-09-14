 complex←Raw2Complex raw
 ⍝ Converts a sequence of coupled values "a b a b" to complex numbers a+ib

 complex←((1 0⍴⍨≢raw)/raw)+0J1×(0 1⍴⍨≢raw)/raw
