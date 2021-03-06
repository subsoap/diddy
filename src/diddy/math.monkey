#Rem
Copyright (c) 2011 Steve Revill and Shane Woolcock
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#End

Function LinearTween:Float(b:Float, c:Float, t:Float, d:Float = 1)
	Local diff:Float = c - b
	Return diff * t / d + b
End

Function QuadTween:Float(b:Float, c:Float, t:Float, d:Float = 1)
	Local diff:Float = c - b
	t /= d / 2
	If t < 1 Return diff / 2 * t * t + b
	t -= 1
	Return -diff / 2 * (t * (t - 2) - 1) + b
End

Function QuinticTween:Float(b:Float, c:Float, t:Float, d:Float = 1)
	Local diff:Float = c - b
	t /= d / 2
	If (t < 1) Return diff / 2 * t * t * t * t * t + b
	t -= 2
	Return diff / 2 * (t * t * t * t * t + 2) + b
End

Function TweenCalc:Float(p1:Float, p2:Float, t:Float)
	Return p1 + t * (p2 - p1)
End

Function TweenSmooth:Float(p1:Float, p2:Float, t:Float)
	Local v:Float = SmoothStep(t)
	Return p1 + v * (p2 - p1)
End

Function SmoothStep:Float(x:Float, interpSmooth:Int = 1)
	For Local i:Int = 0 Until interpSmooth
		x *= x * (3 - 2 * x)
	Next

	Return x
End

Function TweenUp:Float(p1:Float, p2:Float, t:Float)
	Local v:Float = SmoothStep(t)
	v = Pow(v, 2) 'power of 2.
	Return p1 + v * (p2 - p1)
End

Function TweenDown:Float(p1:Float, p2:Float, t:Float)
	Local v:Float = SmoothStep(t)
	v = 1 - Pow(1 - v, 2) 'InvSquared
	Return p1 + v * (p2 - p1)
End

Function Bezier:Float(p1:Float, p2:Float, cp1:Float, cp2:Float, t:Float)
	Local v:Float = p1 * Pow( (1 - t), 3) + 3 * cp1 * Pow( (1 - t), 2) * t + 3 * cp2 * (1 - t) * Pow(t, 2) + p2 * Pow(t, 3)
	Return v
End

Function EaseInBounceTween:Float(b:Float, c:Float, t:Float, d:Float = 1)
	Local diff:Float = c - b
	Return diff - EaseOutBounceTween(d - t, 0, diff, d) + b
End

Function EaseOutBounceTween:Float(b:Float, c:Float, t:Float, d:Float = 1)
	Local diff:Float = c - b
	t /= d
	If (t < (1 / 2.75))
		Return diff * (7.5625 * t * t) + b
	ElseIf(t < (2 / 2.75))
		t -= (1.5 / 2.75)
		Return diff * (7.5625 * t * t + 0.75) + b
	ElseIf(t < (2.5 / 2.75))
		t -= (2.25 / 2.75)
		Return diff * (7.5625 * t * t + 0.9375) + b
	Else
		t -= (2.625 / 2.75)
		Return diff * (7.5625 * t * t + 0.984375) + b
	End
End

Function EaseInOutBounceTween:Float(b:Float, c:Float, t:Float, d:Float = 1)
	Local diff:Float = c - b
	If (t < d / 2)
		Return EaseInBounceTween(t * 2, 0, diff, d) * 0.5 + b
	End
	Return EaseOutBounceTween(t * 2 - d, 0, diff, d) * 0.5 + diff * 0.5 + b
End

Function BackEaseInTween:Float(b:Float, c:Float, t:Float, d:Float = 1, s:Float = 2)
	Local diff:Float = c - b
	t /= d
	Return diff * t * t * ( (s + 1) * t - s) + b
End

Function BackEaseOutTween:Float(b:Float, c:Float, t:Float, d:Float = 1, s:Float = 2)
	Local diff:Float = c - b
	t = t / d - 1
	Return diff * (t * t * ( (s + 1) * t + s) + 1) + b
End

Function BackEaseInOutTween:Float(b:Float, c:Float, t:Float, d:Float = 1, s:Float = 2)
	Local diff:Float = c - b
	Local s2:Float = s
	t /= d / 2
	s2 *= 1.525
	If t < 1
		Return diff / 2 * (t * t * ( (s2 + 1) * t - s2)) + b
	End
	t -= 2
	Return diff / 2 * (t * t * ( (s2 + 1) * t + s2) + 2) + b
End

Function IntToRoman:String(input:Int)
	Local s:String = ""
    While input >= 1000
        s += "M"
        input -= 1000
	End
    While input >= 900
        s += "CM"
        input -= 900
	End
    While input >= 500
        s += "D"
        input -= 500
    End
    While input >= 400
        s += "CD"
        input -= 400
    End
    While input >= 100
        s += "C"
        input -= 100
    End
    While input >= 90
        s += "XC"
        input -= 90
    End
    While input >= 50
        s += "L"
        input -= 50
    End
    While input >= 40
        s += "XL"
        input -= 40
    End
    While input >= 10
        s += "X"
        input -= 10
    End
    While input >= 9
        s += "IX"
        input -= 9
    End
    While input >= 5
        s += "V"
        input -= 5
    End
    While input >= 4
        s += "IV"
        input -= 4
    End
    While input >= 1
        s += "I"
        input -= 1
    End
    Return s
End

Function RomanToInt:Int(input:String)
	Local last:Int = 1
	Local this:Int = 1
	Local rv:Int = 0
	For Local i:Int = input.Length-1 To 0 Step -1
		last = this
		Select input[i]
			Case "I"[0]
				this = 1
			Case "V"[0]
				this = 5
			Case "X"[0]
				this = 10
			Case "L"[0]
				this = 50
			Case "C"[0]
				this = 100
			Case "D"[0]
				this = 500
			Case "M"[0]
				this = 1000
		End
		If last > this Then rv -= this Else rv += this
	Next
	Return rv
End

Class RandomSource
Private
	Field currentSeed:Int
	Field snapshotSeed:Int

	Method NextRnd:Float()
		' cache global seed
		Local lastSeed:Int = Seed
		' update it to be ours if it's not the system one
		If Self <> SystemSource Then Seed = Self.currentSeed
		' call global Rnd function
		Local thisRnd:Float = Rnd()
		' update our seed
		Self.currentSeed = Seed
		' reset global seed if it's not the system one
		If Self <> SystemSource Then Seed = lastSeed
		' return the random float
		Return thisRnd
	End
	
Public
	Global SystemSource:RandomSource = New RandomSource
	
	Method CurrentSeed:Int() Property Return currentSeed End
	Method CurrentSeed:Void(currentSeed:Int) Property Self.currentSeed = currentSeed End
	
	Method New()
		currentSeed = Seed
		snapshotSeed = currentSeed
	End
	
	Method New(seed:Int)
		currentSeed = seed
		snapshotSeed = currentSeed
	End
	
	Method New(other:RandomSource)
		currentSeed = other.CurrentSeed
		snapshotSeed = currentSeed
	End
	
	Method NextInt:Int()
		Return (NextInt($10000) Shl 16) | NextInt($10000)
	End
	
	Method NextInt:Int(n:Int)
		Return Int(NextRnd() * n)
	End
	
	Method NextInt:Int(low:Int, high:Int)
		Return low + Int(NextRnd() * (high-low+1))
	End
	
	Method NextFloat:Float()
		Return NextRnd()
	End
	
	Method NextBool:Bool()
		Return NextRnd() >= 0.5
	End
	
	Method Snapshot:Void()
		snapshotSeed = currentSeed
	End
	
	Method Rollback:Void()
		currentSeed = snapshotSeed
	End
	
	Method Reseed:Void()
		currentSeed = NextInt()
	End
End
