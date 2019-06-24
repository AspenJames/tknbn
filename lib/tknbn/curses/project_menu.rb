class ProjectMenu
	attr_accessor :win, :height, :width, :highlight

	def initialize(height: nil, width: nil)
		# Can be initialized with height and width, but will
		# default to half the size of the currently available window
		Curses.clear
		@height = height || Curses.lines / 2
		@width = width || Curses.cols / 3
		@win = Curses::Window.new(@height, @width, @height/2, @width)

		@highlight = 0
	end

	def get_choice
		begin
			@win.box('|', '-')
			@win.setpos(2, 2)
			@win.addstr("Choose a project or press \"a\" to create a new project")

			loop do # this loop creates a 'scrollable' menu
				display_menu
				c = @win.getch
				case c
				when 'j'
					if @highlight == Project.all.length- 1 # if highlight equals
						@highlight = 0										# the last index, reset
					else
						@highlight += 1										# Otherwise increment
					end
				when 'k'
					if @highlight == 0									# if highlight is zero
						@highlight = Project.all.length 	# reset to end
					else
						@highlight -= 1										# Otherwise decrement
					end
				when 10 # 'Enter' = 10
					@choice = @highlight 								# save the selection
					break								 								# Exit the loop
				when 'a' # This is equivalent to selecting a new project`
					@choice = Project.all.length
					break
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
		opts = Project.most_recently_updated.map(&:name)
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
