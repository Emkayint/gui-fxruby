require 'fox16'
include Fox

class HelloWorld < FXMainWindow
  def initialize(app)
    super(app, "Hello, World!", :width => 200, :height => 200)
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

app = FXApp.new
HelloWorld.new(app)
app.create
app.run