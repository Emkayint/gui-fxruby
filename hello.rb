require "fox16"
include Fox

app = FXApp.new("Hi", "Ruby")
main = FXMainWindow.new(app, "Ruby", :width => 200, :height => 50)
app.create
main.show(PLACEMENT_SCREEN)
app.run()