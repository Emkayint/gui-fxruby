=begin
To create our password we can use Ruby’s Integer#chr method,
which returns a string containing the character 
represented by the receiver’s value. If the user wants 
to include special characters in their password, then 
we can use any of the 93 characters from 33-126 on the
ASCII chart. Otherwise we stick to values 48-57, 65-90 a
nd 97-122 which represent numbers 1-9, uppercase A-Z and
lowercase a-z respectively.
=end

def generatePassword(pwLength, charArray)
  len = charArray.length
  (1..pwLength).map do
    charArray[rand(len)]
  end.join
end

numbers = (1..9).to_a
alphabetLowerCase = ("a".."z").to_a
alphabetUpperCase = ("A".."Z").to_a
allPossibleChars = (33..126).map{|a| a.chr}

p = generatePassword(20, numbers + alphabetLowerCase + alphabetUpperCase)

puts p