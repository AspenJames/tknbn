class ProjectMenu
	attr_accessor :win, :height, :width, :highlight

	def initialize(height: nil, width: nil)
		# Can be initialized with height and width, but will
		# default to half the size of the currently available window
		@height = height || Curses.lines / 2
		@width = width || Curses.cols / 2
		@win = Curses::Window.new(@height, @width, @height/2, @width/2)

		@highlight = 0
	end

	def get_choice
		begin
			@win.box('|', '-')
			@win.setpos(2, 2)
			@win.addstr("Choose an option")

			loop do # this loop creates a 'scrollable' menu
				display_menu
				c = @win.getch
				case c
				when 'B', 'j' # Down arrow or 'j'
					if @highlight == Project.all.length # if highlight equals
						@highlight = 0										# the last index, reset
					else
						@highlight += 1										# Otherwise increment
					end
				when 'A', 'k' # Up arrow or k
					if @highlight == 0									# if highlight is zero
						@highlight = Project.all.length 	# reset to end
					else
						@highlight -= 1										# Otherwise decrement
					end
				when 10 # 'Enter' = 10
					@choice = @highlight 								# save the selection
					break								 								# Exit the loop
				when 'q' #, 27 # when 'q' or ESC
					break
				end
			end
		ensure
			@win.close # make sure the window gets closed
		end
		@choice # Return the selection
	end

	def display_menu
		cur_line = 4 # sets position of fist option
		opts = Project.all.map(&:name)
		opts.push("Create a new project")
		opts.each_with_index do |opt, idx|
			@win.setpos(cur_line, 3)

			if @highlight == idx	# if the current item is to be highlighted:
				@win.attron(Curses::A_REVERSE)
				@win.addstr(opt)
				@win.attroff(Curses::A_REVERSE)
			else
				@win.addstr(opt)
			end
			cur_line += 1 # increment the current line
		end
		@win.refresh	# redraw
	end
end
