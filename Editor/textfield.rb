class TextField < Gosu::TextInput
  # Some constants that define our appearance.
  INACTIVE_COLOR  = 0xcc666666
  ACTIVE_COLOR    = 0xccff6666
  SELECTION_COLOR = 0xcc0000ff
  CARET_COLOR     = 0xffffffff
  
  attr_reader :x, :y
  
  def initialize(window, font, x, y, width, height, label="")
	super()
	@window = window
	@font = font
	@x = x
	@y = y
	@width = width
	@height = height
	@label = label
	self.text = "lolazo"
  end
  
  def draw
    # Depending on whether this is the currently selected input or not, change the
    # background's color.
    if @window.text_input == self then
      background_color = ACTIVE_COLOR
    else
      background_color = INACTIVE_COLOR
    end
    @window.draw_quad(x,    	y, 		background_color,
				x + width, 	y ,          	background_color,
				x,         	y + height, background_color,
				x + width, 	y + height, background_color, 0)
    
    # Calculate the position of the caret and the selection start.
    pos_x = x + @font.text_width(self.text[0...self.caret_pos])
    sel_x = x + @font.text_width(self.text[0...self.selection_start])
    
    # Draw the selection background, if any; if not, sel_x and pos_x will be
    # the same value, making this quad empty.
    @window.draw_quad(sel_x, 	y,         	 	SELECTION_COLOR,
				pos_x, 	y,          		SELECTION_COLOR,
				sel_x, 	y + height, 	SELECTION_COLOR,
				pos_x, 	y + height, 	SELECTION_COLOR, 0)

    # Draw the caret; again, only if this is the currently selected field.
    if @window.text_input == self then
      @window.draw_line(pos_x, 	y,          	CARET_COLOR,
				pos_x, 	y + height, CARET_COLOR, 0)
end
			
	# label
	@font.draw(@label, x, y-15, 0)
	# Finally, draw the text itself!
	@font.draw(self.text, x + 2, y, 0)
  end

  # This text field grows with the text that's being entered.
  # (Without clipping, one has to be a bit creative about this ;) )
  def width
    @width
  end
  
  def height
    @height
  end

  # Hit-test for selecting a text field with the mouse.
  def under_point?(mouse_x, mouse_y)
	mouse_x > x and mouse_x < x + width and
	mouse_y > y and mouse_y < y + height
  end
end