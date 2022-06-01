require "fox16"
include Fox

NUMBERS = (1..9).to_a
ALPHABET_LOWER = ("a".."z").to_a
ALPHABET_UPPER = ("A".."Z").to_a
ALL_POSSIBLE_CHAR = (33..126).map{|a| a.chr}


class PasswordGenerator < FXMainWindow
  def initialize(app, charSets)

    super(app, "Password gen", :width => 400, :height => 200)
    @charSets = charSets

    packer = FXPacker.new(self, :opts => LAYOUT_FILL)
    groupBox = FXGroupBox.new(packer, nil, :opts => FRAME_RIDGE | LAYOUT_FILL_X)

    hFrame1 = FXHorizontalFrame.new(groupBox)
    chrLabel = FXLabel.new(hFrame1, "Number of characters in password:")
    chrTextfield = FXTextField.new(hFrame1, 4)


    hFrame2  = FXHorizontalFrame.new(groupBox) 

    @includeSpecialCharacters = false
    specialChrsCheck = FXCheckButton.new(hFrame2, "Include special characters in password")
    specialChrsCheck.connect(SEL_COMMAND){ @includeSpecialCharacters ^= true}

    vFrame1 = FXVerticalFrame.new(packer, :opts => LAYOUT_FILL )
    textArea = FXText.new(vFrame1, :opts => LAYOUT_FILL | TEXT_READONLY | TEXT_WORDWRAP)


    hFrame3 = FXHorizontalFrame.new(vFrame1, :opts => PACK_UNIFORM_WIDTH)
    generateButton = FXButton.new(hFrame3, "Generate")
    copyButton = FXButton.new(hFrame3, "Copy to clipboard")

    generateButton.connect(SEL_COMMAND) do
      textArea.removeText(0, textArea.length)
      pwLength = [0, chrTextfield.text.to_i].max
      charSet = chooseCharset@includeSpecialCharacters
      textArea.appendText(generatePassword(pwLength, charSet))
    end

    copyButton.connect(SEL_COMMAND) do 
      acquireClipboard([FXWindow.stringType])
    end

    self.connect(SEL_CLIPBOARD_REQUEST) do 
      setDNDData(FROM_CLIPBOARD, FXWindow.stringType, Fox.fxencodeStringData(textArea.text))
    end

  end

  def generatePassword(pwLength, charArray)
    len = charArray.length
    (1..pwLength).map do
      charArray[rand(len)]
    end.join
  end

  def chooseCharset(includeSpecialCharacters)
    if includeSpecialCharacters
      @charSets[0]
    else
      @charSets[1]
    end
  end


  def create 
    super
    show(PLACEMENT_SCREEN)
  end
end

if __FILE__ == $0
  FXApp.new do |app|
    charSets = [ALL_POSSIBLE_CHAR, NUMBERS + ALPHABET_LOWER + ALPHABET_UPPER]

    PasswordGenerator.new(app, charSets)
    app.create
    app.run
  end
end