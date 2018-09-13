=begin
The following list contains the names of individuals who are
pioneers in the field of computing or that have had a significant
influence on the field. The names are in an encrypted form,
though, using a simple (and incredibly weak) form of encryption
called Rot13.(https://en.wikipedia.org/wiki/ROT13)

Nqn Ybirynpr
Tenpr Ubccre
Nqryr Tbyqfgvar
Nyna Ghevat
Puneyrf Onoontr
Noqhyynu Zhunzznq ova Zhfn ny-Xujnevmzv
Wbua Ngnanfbss
Ybvf Unvog
Pynhqr Funaaba
Fgrir Wbof
Ovyy Tngrf
Gvz Orearef-Yrr
Fgrir Jbmavnx
Xbaenq Mhfr
Fve Nagbal Ubner
Zneiva Zvafxl
Lhxvuveb Zngfhzbgb
Unllvz Fybavzfxv
Tregehqr Oynapu

Write a program that deciphers and prints each of these names .

=end

=begin
p: each letter is transformed to -13 places in the alphabet
   it loops back at the end of the alphabet
i: string (sentence)
o: string (sentence)
s: make a range A-Z and a-z
   split input string into words
   split word into letters
   get index of letter in range
   substract 13 from indexnr.
     if result < 0,
       than substract 0 - result from index last element in range
   find the letter for the new index
   add this new letter to the output string
=end

def new_letter(letter)
  alphabet = ('A'..'Z').to_a if /[A-Z]/.match(letter)
  alphabet = ('a'..'z').to_a if /[a-z]/.match(letter)

  last = alphabet.index(alphabet.last)
  index = alphabet.index(letter)

  new_index = index - 13
  new_index = last + 1 + new_index if new_index < 0

  alphabet[new_index]
end

def decode(string)
  string.split.map do |word|
    word.each_char.map do |letter|
      /[a-z]/i.match(letter) ? new_letter(letter) : letter
    end.join
  end.join(' ')
end


p decode('URYYB') #== 'HELLO'
p decode('Nqn Ybirynpr')
p decode('Tenpr Ubccre')
p decode('Noqhyynu Zhunzznq ova Zhfn ny-Xujnevmzv')
p decode('Gvz Orearef-Yrr')
puts


# LS solution:
ENCRYPTED_PIONEERS = ['URYYB',
  'Nqn Ybirynpr',
  'Tenpr Ubccre',
  'Nqryr Tbyqfgvar',
  'Nyna Ghevat',
  'Puneyrf Onoontr',
  'Noqhyynu Zhunzznq ova Zhfn ny-Xujnevmzv',
  'Wbua Ngnanfbss',
  'Ybvf Unvog',
  'Pynhqr Funaaba',
  'Fgrir Wbof',
  'Ovyy Tngrf',
  'Gvz Orearef-Yrr',
  'Fgrir Jbmavnx',
  'Xbaenq Mhfr',
  'Fve Nagbal Ubner',
  'Zneiva Zvafxl',
  'Lhxvuveb Zngfhzbgb',
  'Unllvz Fybavzfxv',
  'Tregehqr Oynapu'
].freeze

def rot13(encrypted_text)
  encrypted_text.each_char.reduce('') do |result, encrypted_char|
    result + decipher_character(encrypted_char)
  end
end

def decipher_character(encrypted_char)
  case encrypted_char
  when 'a'..'m', 'A'..'M' then (encrypted_char.ord + 13).chr
  when 'n'..'z', 'N'..'Z' then (encrypted_char.ord - 13).chr
  else                         encrypted_char
  end
end

ENCRYPTED_PIONEERS.each do |encrypted_name|
  puts rot13(encrypted_name)
end

=begin
Discussion

It's tempting to use a lookup table with a hash to solve this
problem, but it's actually easier to use the description of
Rot13 directly ("rotate" each character by 13), so that's what
we will do.

Our program begins by setting up a constant Array that contains
our encrypted list of pioneers.

We will use a method, rot13, to decrypt each name in the list,
one at a time, and within that method, we use decipher_character
to decrypt each character. We use String#each_char and
Enumerable#reduce to iterate through the characters in
encrypted_text, and construct the decrypted return value.

decipher_character uses a case statement that breaks the character
decryption problem into 3 parts: the letters between A and M, the
letters between N and Z, and everything else. Note that we check
for both uppercase and lowercase letters because that's what we
have to deal with. The first group is easy: we can shift the
character 13 places forward ('A' becomes 'N', 'B' becomes 'O',
..., 'M' becomes 'Z'). We do this with String#ord and Integer#chr
which convert a character to a numeric value and vice versa.
Similarly, we do the same for the 2nd group, but this time
we need to shift letters to the left by 13 places ('N' becomes
'A', 'O' becomes 'B', etc). Lastly, we can handle everything
else by returning the value unchanged.

Once we have all the components in place, all we have to do is
iterate through our list of encrypted names, and print each
decrypted name.
Further Exploration

If there is anybody on this list whose name you don't recognize
- and there probably are some - you owe it to yourself to look
them up. Everybody should be aware of the pioneers in their
chosen field, and computing is no different.

Most computers today use a character encoding called ASCII to
store the basic set of characters such as latin letters, Arabic
digits, and some punctuation. This encoding is convenient in that
the lowercase letters all have consecutive values between 97 and
122, while the uppercase letters have consecutive values between
65 and 90. This makes implementation of Rot13 easy.

Not all computers use ASCII. Some mainframes use different
schemes such as EBCDIC, which some IBM computers use. EBCDIC
is unusual: the alphabetic characters are not all grouped
together like in ASCII (see the linked page). How would this
impact our implementation of this program if we were running
this program on data that uses the EBCDIC representation?
=end