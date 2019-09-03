# typed: false

module Tknbn
	class ProjectChoiceMenu
		extend T::Sig
		attr_reader :win, :height, :width, :highlight
		attr_accessor :choice

		sig {void}
		def initialize
			Curses.clear
			@height = Curses.lines/2
			@width = Curses.cols/3
			@win = Curses::Window.new(@height, @width, @height/2, @width)
			draw_box_and_header
			@highlight = 0
			@choice = Project.all.length
		end

		sig {void}
		def draw_box_and_header
			@win.box('|', '-')
			@win.setpos(2,2)
			@win.addstr('Choose a project or press "a" to create a new project')
			@win.refresh
		end

		sig {returns(Integer)}
		def get_choice
			begin
				loop do
					display_menu
					c = @win.getch
					case c
					when "j"
						move_highlight_down
					when "k"
						move_highlight_up
					when 10
						@choice = @highlight
						break
					when "a"
						choice = Project.all.length
						break
					end
				end
			ensure
				@win.close
			end
			@choice
		end

		sig {void}
		def display_menu
			cur_line = 4 #sets line position for first option
			opts = Project.most_recently_updated.map(&:name)
			opts.each_with_index do |opt, idx|
				@win.setpos(cur_line, 3)
				if @highlight == idx
					@win.attron(Curses::A_REVERSE)
					@win.addstr(opt)
					@win.attroff(Curses::A_REVERSE)
				else
					@win.addstr(opt)
				end
				cur_line += 1
			end
			@win.refresh
		end

		sig {void}
		def move_highlight_down
			if @highlight == Project.all.length - 1
				@highlight = 0
			else
				@highlight += 1
			end
		end

		sig {void}
		def move_highlight_up
			if @highlight == 0
				@highlight = Project.all.length - 1
			else
				@highlight -= 1
			end
		end
	end
end
